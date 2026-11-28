/* OS9 ViewGIF 2.0   Copyright (C) 1989 by Vaughn Cato */

/* This program was specifically written for OS9 on the Tandy Color */
/* Computer 3 as it's graphics routines will only work on that system. */
/* The GIF decoding routines were originally taken from the Apollo */
/* workstation version of viewgif by Ben Samit.  As noted in the source */
/* code provided by Ben, most of his code was taken from a GIF to */
/* PostScript converter by Scott Hemphill.  Because of their consideration */
/* in providing the source code with their respective programs I am doing */
/* the same.  */
/* I encourage you to send any enhancements in the Color Computer version */
/* you wish to be publicly distributed to me so that I may update the */
/* program and re-release it.  In this way, a standard version of the */
/* program can be maintained. */

/*    My address is:         */
/*       Vaughn Cato         */
/* 1244 E. Piedmont Rd. NE   */
/*    Marietta, Ga. 30062    */

/* Any portion of this program may be freely used in any software provided */
/* the source for that program is made freely available to the public and */
/* credit is given to me, Ben Samit, and Scott Hemphill. */

#include "port.h"

#undef FALSE
#undef TRUE
#define FALSE 0
#define TRUE (!FALSE)


typedef char bool;
/* Prefix indexes and suffix bytes avoid storing a redundant first byte and
   avoid per-record padding. Each LZW prefix always precedes its entry. */
int codeprefix[4096];
vg_byte codesuffix[4096];
int outcode(int code);
int firstcode(int code);

/* Startup values are grouped separately from the large LZW work tables. */
int winfile = -1,
    winfile2 = -1,
    myheight=192,
    magfact=1,
    startx=0,
    starty=0,
    greytype=0,
    aligned=0,
    vefon=0,
    realrand=0,
    dispon=1,
    infomode=1,
    pauselen= -1,
    newscrn=1,
    flicker=1,
    britefac=16;
char *usefname=NULL, *vefname=NULL;

FILE     *infile;
int ilevtab[192],
    cmsize,
    cmsize2,
    globbits,
    datasize,
    codesize,
    codemask,
    clear,
    eoi,
    scrnwid,
    scrnhght,
    windesc,
    actwin,
    mywidth,
    dfactor,
    groupnum,
    bufnum,
    gmode,
    newuse,
    framenum;
vg_byte linestor[640];
vg_byte     globmap[256][3],
         cocomap[16][3],
         cocomap2[16][3],
         cococolr[16],
         cococol2[16],
         codestk[4096],
         coloruse[256],
         randtab[16][16];
char *gpbufptr;
struct trantype transtab[256][4];
bool     global;
unsigned WIDTH,
         HEIGHT;

int main(int argc, char **argv)
{
  char ch,*p,opt;
  bool quit;
  int x,argnum;

  dfactor=42;
  for (x=0;x<256;++x)
    coloruse[x]=1;
  for (argnum=1;argnum<argc;++argnum) {
    if (argv[argnum][0]=='-') {
      p= &argv[argnum][1];
      while (*p) {
        opt= *p++;
        if (*p=='=')
          ++p;
        switch (opt) {
          case 'd':
            if (*p=='\0')
              dfactor=0;
            else {
              dfactor=vg_atoi(p);
              if (dfactor < -85 || dfactor>42)
                error("bad dithering",1);
            }
            break;
          case 'u':
            usefname = p;
            break;
          case 'm':
            magfact=vg_atoi(p);
            if (magfact<1 || magfact>64)
              error("bad magnification",1);
            break;
          case 'x':
            startx=vg_atoi(p);
            if (startx<1 || startx>64)
              error("bad x offset",1);
            break;
          case 'y':
            starty=vg_atoi(p);
            if (starty<1 || starty>64)
              error("bad y offset",1);
            break;
          case 'g':
            greytype=(*p=='2') ? 2 : 1;
            break;
          case 'a':
            aligned=1;
            goto next_option;
          case 'v':
            dispon=vefon=1;
            if (*p!='\0')
              vefname=p;
            break;
          case 'r':
            realrand=1;
            goto next_option;
          case 's':
            infomode=0;
            goto next_option;
          case 'i':
            if (newscrn)
              infomode=2;
            goto next_option;
          case 'n':
            if (vefname==NULL)
              dispon=0;
            goto next_option;
          case 'p':
            pauselen=vg_atoi(p);
            break;
          case 'c':
            newscrn=0;
            infomode=0;
            goto next_option;
          case 'f':
            flicker=0;
            goto next_option;
          case 'b':
            britefac=vg_atoi(p);
            if (britefac<1 || britefac>16)
              error("bad brightness",1);
            break;
          default:
            fatal("Unknown option");
        }
        break;
next_option:
        ;
      }
      for (x=argnum+1;x<argc;++x)
        argv[x-1]=argv[x];
      --argc;
      --argnum;
    }
  }
  if (flicker && dfactor>21)
    dfactor=21;
  if (argc<2)
    usage();
  infile=fopen(argv[1],"r");
  if (infile==NULL)
    error("Cannot open input file",errno);
  checksig();
  readscrn();
  makerand();
  quit=FALSE;
  framenum=0;
  do {
    ch=getc(infile);
    switch(ch) {
      case '\0':
        break;
      case ',':
        ++framenum;
        readimag();
        waituser();
        break;
      case ';':
        quit=TRUE;
        break;
      case '!':
        readext();
        break;
      default:
        quit=TRUE;
        break;
    }
    if (!dispon && vefname==NULL && (usefname==NULL || !newuse))
      break;
  } while (!quit);
  fclose(infile);
  if (dispon)
    killwind();
  if (dispon) {
    actwin=1;
    vg_select();
    flushwin();
  }
  if (winfile>=0) close(winfile);
  if (winfile2>=0) close(winfile2);
  return 0;
}

/* A 16-bit generator gives all host compilers the same dithering sequence
   without pulling a wide-integer host-library random implementation. */
int vg_rand(void)
{
  static unsigned seed=1;
  seed=(seed>>1) ^ ((seed&1) ? 0xb400 : 0);
  return seed & 0x7fff;
}

int makerand(void)
{
  int ax,ay,x,t,r;

  for (x=0;x<256;++x)
    randtab[x>>4][x&15]=(x*(flicker ? 10 : 21)) >> 8;
  for (x=0;x<256;++x) {
    r=vg_rand()&255;
    t=randtab[r>>4][r&15];
    randtab[r>>4][r&15]=randtab[x>>4][x&15];
    randtab[x>>4][x&15]=t;
  }
  for (x=0;x<256;++x) {
    ay=x>>4;
    ax=x&15;
    if ((ax+ay)&1)
      randtab[ax][ay]+=(flicker ? 21 : 43);
    if (ax&1)
      randtab[ax][ay]+=(flicker ? 10 : 21);
/*
    if (((ax>>1) + (ay>>1))&1)
      randtab[ax][ay]+=(flicker ? 10 : 21);
*/
  }
  return 0;
}

int readuse(void)
{
  char newname[64],*ep;
  int usefile,x;

  if (!usefname) { newuse=0; return 0; }
  if (strlen(usefname)>50) error("usage name too long",1);
  strcpy(newname,usefname);
  if (framenum>1) {
    ep=newname+strlen(newname);
    itoa(framenum,ep);
  }
  if ((usefile=open(newname,1))==-1) {
    for (x=0;x<256;++x)
      coloruse[x]=1;
    newuse=1;
  } else {
    newuse=0;
    read(usefile,coloruse,256);
    close(usefile);
    if (infomode>0)
      VG_INFO("Using usage file\n");
  }
  return 0;
}

int writeuse(void)
{
  int x,usecount=0,usefile;
  char newname[64],*ep;

  for (x=0;x<(1<<globbits);++x)
    if (coloruse[x])
      ++usecount;
  if (infomode>0)
    VG_INFO("%d out of %d colors used.\n",usecount,1<<globbits);
  if (usefname!=NULL) {
    usecount=0;
    if (strlen(usefname)>50) error("usage name too long",1);
  strcpy(newname,usefname);
    if (framenum>1) {
      ep=newname+strlen(newname);
      itoa(framenum,ep);
    }
    if (newuse) {
      if ((usefile=creat(newname,3))==-1)
        error("Cannot create usage file",errno);
      else {
        write(usefile,(char *)coloruse,1<<globbits);
        close(usefile);
      }
    }
  }
  return 0;
}

int saveimag(void)
{
  char newname[64],*ep,c;
  int file,x,scrnum,scrntype=0;

  for (scrnum=0;scrnum<=flicker;++scrnum) {
    if (strlen(vefname)>50) error("VEF name too long",1);
    strcpy(newname,vefname);
    if (framenum>1) {
      ep=newname+strlen(newname);
      itoa(framenum,ep);
    }
    if (scrnum==1)
      strcat(newname,".2");
    actwin=(scrnum==0) ? winfile : winfile2;
    vg_select();
    flushwin();
    if ((file=creat(newname,3))==-1)
      error("Cannot create vef file",errno);
    write(file,(char *)&scrntype,sizeof(scrntype));
    write(file,(char *)((scrnum==0) ? cococolr : cococol2),16);
    for (x=0;x<8;++x)
      write(file,(char *)gpbufptr,160);
    for (x=0;x<192;++x) {
      getblk(groupnum,bufnum,x);
      flushwin();
      write(file,(char *)gpbufptr,160);
    }
    close(file);
  }
  return 0;
}

int readext(void)
{
  int code,count;
  vg_byte buf[255];

  code=getc(infile);
  if (code==EOF) fatal("short extension");
  while ((count=getc(infile))!=0) {
    if (count==EOF || fread(buf,1,count,infile)!=count)
      fatal("short extension");
  }
  return 0;
}

int real_x;
int real_y;
int y_coord;
int x_coord;
long sample_edge,sample_limit,sample_step;

int readimag(void)
{
  vg_byte buf[9];
  unsigned left,top,width,height;
  bool local,intrlevd;
  int lclbits;
  int row;
  int i,j;
  int n;
  int lineread;
  int hold,xpos;
  int x,y;
  char *newrast;

  readuse();
  newwind();
  if (fread(buf,1,9,infile)!=9) fatal("short image header");
  left=(buf[0] & 0xff) | (buf[1]<<8);
  top=(buf[2] & 0xff) | (buf[3]<<8);
  width=(buf[4] & 0xff) | (buf[5]<<8);
  height=(buf[6] & 0xff) | (buf[7]<<8);
  WIDTH=width;
  HEIGHT=height;
  if (!WIDTH || !HEIGHT || WIDTH>32767 || HEIGHT>32767) fatal("invalid image size");
  if (infomode>0)
    VG_INFO("gif dimensions : %d x %d pixels\n",WIDTH,HEIGHT);
  local=buf[8] & 0x80;
  intrlevd=buf[8] & 0x40;
  if (local) {
    char tempbuf[3];
    fatal("local palette unsupported");

    lclbits=(buf[8] & 0x7) +1;
    for (x=1<<lclbits;x>0;--x)
      fread(tempbuf,3,1,infile);
  } else if (!global)
    fatal("no colormap present for image");
  lineread=0;
  for (i=0;i<192;++i)
    ilevtab[i]= -1;
  if (aligned) {
    n=HEIGHT;
    while (n>200)
      n/=2;
    n*=magfact;
  } else
    n=myheight*magfact;
  if (intrlevd) {
    for (j=8;j>0;j/=2)
      for (i=(j%8);i<HEIGHT;i+=(j*2-1)%8+1) {
        row=(long)i*n/HEIGHT-starty*3*magfact;
        if (row>=0 && row<192)
          ilevtab[row]=lineread;
        ++lineread;
      }
  } else {
    for (i=0;i<HEIGHT;++i) {
      row=(long)i*n/HEIGHT-starty*3*magfact;
      if (row>=0 && row<192)
        ilevtab[row]=lineread;
      ++lineread;
    }
  }
  real_x=0;
  real_y=0;
  x_coord=0;
  y_coord=0;
  if (dispon || (usefname!=NULL && newuse)) {
    readrast(width,height);
    writeuse();
    if (vefname!=NULL)
      saveimag();
  }
  return 0;
}

unsigned datum;
int rasterdone;
int bits;
vg_byte buf[255];

int readrast(unsigned width, unsigned height)
{
  int count, code, i;
  datasize=getc(infile);
  if (datasize<2 || datasize>8) fatal("invalid GIF code size");
  clear=1<<datasize;
  eoi=clear+1;
  codesize=datasize+1;
  codemask=(1<<codesize)-1;
  datum=0;
  bits=0;
  rasterdone=0;
  for (code=0;code<clear;++code) {
    codeprefix[code]=-1;
    codesuffix[code]=code;
  }
  for (;;) {
    count=getc(infile);
    if (count==EOF) fatal("short raster");
    if (!count) break;
    if (fread(buf,1,count,infile)!=count) fatal("short block");
    for (i=0;i<count;++i) addbyte(buf[i]);
  }
  if (!rasterdone) fatal("missing GIF end code");
  return 0;
}

int addbyte(vg_byte c)
{
  int code,bit,octet=c&255;
  if (rasterdone) return 0;
  /* Build at most twelve bits, without a target-dependent long shift. */
  for (bit=0;bit<8;++bit) {
    datum|=(octet&1)<<bits;
    octet>>=1;
    ++bits;
    if (bits==codesize) {
      code=datum;
      datum=0;
      bits=0;
      if (code==eoi) { rasterdone=1; return 0; }
      process(code);
    }
  }
  return 0;
}

int process(int code)
{
  static int avail,oldcode;
  int first;
  if (code==clear) {
    codesize=datasize+1;
    codemask=(1<<codesize)-1;
    avail=clear+2;
    oldcode=-1;
  } else if (code>=0 && code<avail) {
    first=outcode(code);
    if (oldcode!=-1 && avail<4096) {
      codeprefix[avail]=oldcode;
      codesuffix[avail]=first;
      ++avail;
      if ((avail & codemask)==0 && avail<4096) {
        ++codesize;
        codemask+=avail;
      }
    }
    oldcode=code;
  } else if (code==avail && oldcode!=-1 && avail<4096) {
    codeprefix[avail]=oldcode;
    codesuffix[avail]=firstcode(oldcode);
    outcode(avail++);
    if ((avail & codemask)==0 && avail<4096) {
      ++codesize;
      codemask+=avail;
    }
    oldcode=code;
  } else fatal("illegal code in raster data");
  return 0;
}

int firstcode(int code)
{
  int depth=0;
  while (codeprefix[code]>=0) {
    if (++depth>=4096) fatal("invalid GIF prefix chain");
    code=codeprefix[code];
  }
  return codesuffix[code]&255;
}

int outcode(int code)
{
  vg_byte *sp=codestk;
  int x, first;

  while (code>=0) {
    if (code>=4096 || sp>=codestk+sizeof(codestk))
      fatal("GIF code stack overflow");
    *sp++=codesuffix[code];
    code=codeprefix[code];
  }
  first=sp[-1]&255;
  while (sp>codestk) {
    --sp;
#ifdef VIEWGIF_TEST
    vg_test_pixel(*sp & 255);
#endif
    coloruse[*sp & 0xff]=1;
    if (real_x==0) {
      sample_step=(long)mywidth*magfact;
      sample_edge=WIDTH;
      sample_limit=sample_step*(1-startx*(WIDTH/64));
      y_coord= -1;
      for (x=0;x<myheight;++x)
        if (ilevtab[x]==real_y) {
          y_coord=x;
          break;
        }
    }
    if (y_coord != -1)
      while (x_coord<mywidth && sample_edge<=sample_limit) {
        linestor[x_coord++]=(*sp & 0xff);
        sample_edge+=WIDTH;
      }
    sample_limit+=sample_step;
    if (++real_x>=WIDTH) {
      if (y_coord != -1 && dispon)
        do {
          doline();
        } while (++y_coord<192 && ilevtab[y_coord]==-1);
      real_x=0;
      x_coord=0;
      ++real_y;
    }
  }
  return first;
}

int bitcount;
char *byteptr;

int doline(void)
{
  int addval,n,x,scrnum;
  struct trantype *p;

  for (scrnum=1;scrnum>=(flicker ? 0 : 1);--scrnum) {
    actwin=scrnum ? winfile : winfile2;
    bitcount=gmode ? 4 : 2;
    byteptr=gpbufptr;
    if (dfactor>0)
      for (x=0;x<mywidth;++x) {
        addval=realrand ? rand85(y_coord+x) : randtab[x&15][y_coord&15];
        p=transtab[linestor[x]&255];
        for (n=1;n<4 && p[n].addval<=addval;++n);
        addpixel(scrnum ? VG_MAP1(p[n-1]) : VG_MAP2(p[n-1]));
      }
    else
      for (x=0;x<mywidth;++x)
        addpixel(scrnum ? VG_MAP1(transtab[linestor[x]&255][0]) :
                          VG_MAP2(transtab[linestor[x]&255][0]));
    vg_select();
    putblk(groupnum,bufnum,y_coord);
    flushwin();
  }
  return 0;
}

int addpixel(int c)
{
  *byteptr=(char)(((unsigned)*byteptr << (gmode ? 2 : 4)) | c);
  if (--bitcount==0) {
    ++byteptr;
    bitcount=gmode ? 4 : 2;
  }
  return 0;
}

int rand85(int n)
{
  return((n&1 ? 43 : 0) + (vg_rand() % 42));
}

int readscrn(void)
{
  vg_byte buf[7];
  int x;

  if (fread(buf,1,7,infile)!=7) fatal("short screen");
  scrnwid=(buf[0] & 0xff) | (buf[1] << 8);
  scrnhght=(buf[2] & 0xff) | (buf[3] << 8);
  if (infomode>0)
    VG_INFO("%d x %d screen\n",scrnwid,scrnhght);
  global=buf[4] & 0x80;
  if (global) {
    globbits=(buf[4] & 0x07) + 1;
    if (infomode>0)
      VG_INFO("global bitmap : %d colors\n",(1<<globbits));
    if (fread(globmap,3,1<<globbits,infile)!=(1<<globbits))
      fatal("short palette");
    if (infomode>1)
      for (x=0;x<(1<<globbits);++x)
        VG_INFO("color %d = %3d,%3d,%3d\n",x,
                 globmap[x][0] & 0xff,
                 globmap[x][1] & 0xff,
                 globmap[x][2] & 0xff);
  } else
    fatal("cannot handle non-global bitmaps");
  return 0;
}

int newwind(void)
{
  int x,y,hival,loval,midval,toobig;

  fixgmap();
  midval=hival=dfactor;
  loval= -85;
  if (infomode>0) {
    VG_INFO("Analyzing..");
    fflush(stdout);
  }
  while (loval<=hival) {
    dfactor=midval;
    toobig=flicker ? setmap2() : setmap();
    if (infomode>0) {
      VG_INFO(".");
      fflush(stdout);
    }
    if (toobig)
      hival=midval-1;
    else
      loval=midval+1;
    midval=(hival+loval)/2;
  }
  if (infomode>0)
    VG_INFO("\n");
  if (dfactor != hival) {
    dfactor=hival;
    if (flicker)
      setmap2();
    else
      setmap();
  }
  if (infomode>0) {
    VG_INFO("Dithering factor=%d\n",(dfactor>0 ? dfactor : 0));
    VG_INFO("Color tolerance=%d\n",(dfactor<0 ? -dfactor : 0));
    VG_INFO("Resulting coco map:\n");
    VG_INFO("%d colors\n",cmsize);
    if (flicker)
      VG_INFO("%d colors\n",cmsize2);
  }
  if (infomode>1) {
    for (x=0;x<cmsize;++x)
      VG_INFO("%2d:%d,%d,%d=%d\n",x,cocomap[x][0],cocomap[x][1],cocomap[x][2],
                                   cococolr[x]);
    VG_INFO("\n");
    for (x=0;x<cmsize2;++x)
      VG_INFO("%2d:%d,%d,%d=%d\n",x,cocomap2[x][0],cocomap2[x][1],
                                   cocomap2[x][2],cococol2[x]);
    VG_INFO("Translation table:\n");
    for (x=0;x<(1<<globbits);++x) {
      if (coloruse[x]) {
        VG_INFO("%3d:",x);
        for (y=0;y<4 && transtab[x][y].addval<85;++y) {
          VG_INFO(" %3d=%3d",transtab[x][y].addval,VG_MAP1(transtab[x][y]));
          if (flicker)
            VG_INFO(",%3d",VG_MAP2(transtab[x][y]));
        }
        VG_INFO("\n");
      }
    }
  }
  gmode=(cmsize<=4 && !vefon);
  mywidth=(gmode ? 640 : 320);
  if (dispon) {
    initwin();
    for (x=0;x<cmsize;++x)
      palette(x,cococolr[x]);
    flushwin();
    if (flicker) {
      initwin2();
      for (x=0;x<cmsize2;++x)
        palette(x,cococol2[x]);
      flushwin();
    }
  }
  for (x=0;x<(1<<globbits);++x)
    coloruse[x]=0;
  return 0;
}

int fixgmap(void)
{
  int x,r,g,b;

  for (x=0;x<(1<<globbits);++x) {
    if (coloruse[x]) {
      r=globmap[x][0] & 0xff;
      g=globmap[x][1] & 0xff;
      b=globmap[x][2] & 0xff;
      switch (greytype) {
        case 1:
          r=g=b=(r+g+b)/3;
          break;
        case 2:
          if (g>r)
            r=g;
          if (b>r)
            r=b;
          g=b=r;
          break;
      }
      globmap[x][0]=(britefac*r)>>4;
      globmap[x][1]=(britefac*g)>>4;
      globmap[x][2]=(britefac*b)>>4;
    }
  }
  return 0;
}

int killwind(void)
{
  vg_mapgpb(winfile,groupnum,bufnum,0);
  killbuf(groupnum,bufnum);
  return 0;
}

int waituser(void)
{
  char c;
  int x;

  if (!dispon)
    return 0;
  if (pauselen<0) {
    for (x=5;x>0;--x)
      bell();
    flushwin();
  }
  if (flicker) {
    pauselen*=30;
    for (;;) {
      actwin=winfile;
      vg_select();
      flushwin();
      vg_sleep(2);
      if (vg_ready(winfile)) {
        read(winfile,&c,1);
        if (c==13)
          break;
      }
      actwin=winfile2;
      vg_select();
      flushwin();
      vg_sleep(2);
      if (vg_ready(winfile2)) {
        read(winfile2,&c,1);
        if (c==13)
          break;
      }
      if (pauselen==0)
        break;
      if (pauselen>0)
        --pauselen;
    }
  } else {
    if (pauselen>0)
      vg_sleep(60*pauselen);
    else if (pauselen<0)
      do {
        read(winfile,&c,1);
      } while (c!=13);
  }
  return 0;
}

int vg_ready(int path)
{
  return _gs_rdy(path)>0;
}

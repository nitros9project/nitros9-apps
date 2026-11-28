/* gifwin.c - window functions for ViewGIF 2.0 */
/* by Vaughn Cato */

#include "port.h"

extern int winfile,winfile2,groupnum,bufnum,gmode,newscrn,actwin,flicker;
extern char *gpbufptr;
extern FILE *infile;

int minadd(vg_byte * colors, int add)
{
  int minval=85,tryadd,x;

  for (x=0;x<3;++x)
    if ((tryadd=85-(((colors[x] & 0xff)+add)%85))<minval)
      minval=tryadd;
  return(minval+add);
}

int minadd2(vg_byte * colors, int add)
{
  int minval=43,tryadd,x;

  for (x=0;x<3;++x)
    if ((tryadd=43-(((colors[x] & 0xff)+add)%43))<minval)
      minval=tryadd;
  return(minval+add);
}

int tolerval(char * cm, int r, int g, int b)
{
  int mv=0,rd,gd,bd,v;

  rd=cm[0]*85+42;
  gd=cm[1]*85+42;
  bd=cm[2]*85+42;
  if (r<rd-42)
    v=rd-42-r;
  else if (r>rd+42)
    v=r-rd-42;
  else
    v=0;
  if (v>mv)
    mv=v;
  if (g<gd-42)
    v=gd-42-g;
  else if (g>gd+42)
    v=g-gd-42;
  else
    v=0;
  if (v>mv)
    mv=v;
  if (b<bd-42)
    v=bd-42-b;
  else if (b>bd+42)
    v=b-bd-42;
  else
    v=0;
  if (v>mv)
    mv=v;
  return(mv);
}

int toler2(char * cm1, char * cm2, int r, int g, int b)
{
  int mv=0,rd,gd,bd,v;
  char cm[3];

  rd=(cm1[0]+cm2[0])*43+21;
  gd=(cm1[1]+cm2[1])*43+21;
  bd=(cm1[2]+cm2[2])*43+21;
  if (r<rd-21)
    v=rd-21-r;
  else if (r>rd+21)
    v=r-rd-21;
  else
    v=0;
  if (v>mv)
    mv=v;
  if (g<gd-21)
    v=gd-21-g;
  else if (g>gd+21)
    v=g-gd-21;
  else
    v=0;
  if (v>mv)
    mv=v;
  if (b<bd-21)
    v=bd-21-b;
  else if (b>bd+21)
    v=b-bd-21;
  else
    v=0;
  if (v>mv)
    mv=v;
  return(mv);
}

int colorval(int r, int g, int b)
{
  return((r&2)<<4 | (r&1)<<2 | (g&2)<<3 | (g&1)<<1 | (b&2)<<2 | (b&1));
}

int checksig(void)
{
  char buf[6];

  if (fread(buf,1,6,infile)!=6) fatal("short signature");
  if (strncmp(buf,"GIF",3))
    fatal("file is not a GIF file");
  if (strncmp(&buf[3],"87a",3))
    fatal("unsupported GIF version");
  return 0;
}

int fatal(char * str)
{
  fclose(infile);
  close(winfile);
  if (flicker)
    close(winfile2);
  fprintf(stderr,"viewgif: %s\n",str);
  exit(1);
}

int error(char * str, int errnum)
{
  fprintf(stderr,"viewgif: %s\n",str);
  exit(errnum);
}

int vg_sleep(int ticks)
{
  registers_6809 r;
  memset(&r,0,sizeof(r));
  r.x=ticks;
  return _os_syscall(0x0a,&r);
}

int usage(void)
{
  writestr(2,"OS9 ViewGIF 2.0 by Vaughn Cato\rusage: viewgif <filename> [-<option> ...]\r       displays a gif picture\r  options:\r       -d[[=]dfactor] set dithering factor, default is 0\r");
  writestr(2,"       -a align to pixels\r       -u[=]<filename> create/use a color usage file\r       -m[=]<magfact> magnification factor (1-64)\r       -x[=]<start x> set start x (0-64)\r");
  writestr(2,"       -y[=]<start y> set start y (0-64)\r       -v[[=]<filename>] generate vef format picture\r       -g grey scale picture (average color brite)\r");
  writestr(2,"       -g2 grey scale picture (max color brite)\r       -r Use random generator instead of table\r       -s Silent.  No info printed\r       -i Extended information\r");
  writestr(2,"       -n No display\r       -p[[=]seconds] Pause time (default 0)\r       -c Use current screen\r       -f Disable flicker\r       -b[=]<britefact> Set brightness (1-16)\r");
  exit(1);
}

int initwin(void)
{
  int x,newwin,windesc;

  newwin=(winfile == -1);
  if (newscrn)
    windesc=vg_attach("w");
  if (newwin) {
    if (newscrn) {
      if ((winfile=open("/w",3))==-1)
        exit(errno);
    } else {
      winfile=1;
      dwend();
    }
  }
  actwin=winfile;
  if (!newwin)
    dwend();
  dwset(gmode ? 7:8);
  curoff();
  vg_select();
  flushwin();
  if (newscrn)
    vg_detach(windesc);
  if (newwin) {
    groupnum=vg_procid();
    bufnum=1;
    getblk(groupnum,bufnum,0);
    flushwin();
    if ((gpbufptr=vg_mapgpb(winfile,groupnum,bufnum,1))==NULL)
      exit(errno);
  }
  return 0;
}

int initwin2(void)
{
  int x,newwin,windesc;

  newwin=(winfile2 == -1);
  windesc=vg_attach("w");
  if (newwin) {
    if ((winfile2=open("/w",3))==-1)
      exit(errno);
  }
  actwin=winfile2;
  if (!newwin)
    dwend();
  dwset(gmode ? 7:8);
  curoff();
  vg_select();
  flushwin();
  vg_detach(windesc);
  return 0;
}

/* Only the full-screen 4/16-color modes are used by these viewers. */
int dwset(int sty)
{
  static char outstr[]={0x1b,0x20,0,0,0,0,24,0,0,0};
  outstr[2]=sty;
  outstr[5]=(sty==7 ? 80 : 40);
  writemem(outstr,sizeof(outstr));
  return 0;
}

int dwend(void)
{
  static char outstr[]={
    0x1b,0x24
  };

  writemem(outstr,sizeof(outstr));
  return 0;
}

int vg_select(void)
{
  static char outstr[]={
    0x1b,0x21
  };

  writemem(outstr,sizeof(outstr));
  return 0;
}

int bell(void)
{
  char c=7;
  writemem(&c,1);
  return 0;
}

int palette(int prn, int ctn)
{
  static char outstr[]={
    0x1b,0x31,0,0
  };

  outstr[2]=prn;
  outstr[3]=ctn;
  writemem(outstr,sizeof(outstr));
  return 0;
}

int curoff(void)
{
  static char outstr[]={
    0x05,0x20
  };

  writemem(outstr,sizeof(outstr));
  return 0;
}

int vg_procid(void)
{
  return getpid();
}

int getblk(int grp, int bfn, int row)
{
  static char outstr[]={
    0x1b,0x2c,0,0,0,0,0,0,2,127,0,1
  };

  outstr[2]=grp;
  outstr[3]=bfn;
  *(int *)(&outstr[6])=row;
  writemem(outstr,sizeof(outstr));
  return 0;
}

int putblk(int grp, int bfn, int row)
{
  static char outstr[]={
    0x1b,0x2d,0,0,0,0,0,0
  };

  outstr[2]=grp;
  outstr[3]=bfn;
  *(int *)(&outstr[6])=row;
  writemem(outstr,sizeof(outstr));
  return 0;
}

int killbuf(int grp, int bfn)
{
  static char outstr[]={
    0x1b,0x2a,0,0
  };

  outstr[2]=grp;
  outstr[3]=bfn;
  writemem(outstr,sizeof(outstr));
  return 0;
}

char * vg_mapgpb(int path, int grp, int bfn, int action)
{
  registers_6809 r;
  memset(&r,0,sizeof(r));
  r.a=path;
  r.b=0x84;
  r.x=(grp<<8)|(bfn&255);
  r.y=action;
  if (_os_syscall(0x8e,&r)!=0) return NULL;
  return (char *)r.x;
}

int writemem(char * str, int size)
{
  while (size-- > 0)
    writechr(*str++);
  return 0;
}

char outbuf[256];
char *outptr=outbuf;

int writechr(char c)
{
  if (outptr>=outbuf+sizeof(outbuf))
    flushwin();
  *outptr++ = c;
  return 0;
}

int flushwin(void)
{
  write(actwin,outbuf,outptr-outbuf);
  outptr=outbuf;
  return 0;
}

int vg_attach(char * str)
{
  registers_6809 r;
  memset(&r,0,sizeof(r));
  r.a=3;
  r.x=(int)str;
  if (_os_syscall(0x80,&r)!=0) return -1;
  return r.u;
}

int vg_detach(int dte)
{
  registers_6809 r;
  memset(&r,0,sizeof(r));
  r.u=dte;
  return _os_syscall(0x81,&r);
}

int writestr(int file, char *str)
{
  return write(file,str,strlen(str));
}

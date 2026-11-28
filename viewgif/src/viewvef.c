/* ViewVEF 1.0 by Vaughn Cato */
/* For use in displaying flicker VEF files */

#include "port.h"

int actwin;
char *gpbufptr;

int main(int argc, char **argv)
{
  int winfile1,winfile2,x,     groupnum,bufnum,
      flicker=0, file,    scrnum,pauselen= -1;
  char c,newname[128];

  if (argc<2) {
    writestr(1,"Usage: viewvef <vef file> [<pause length>]\r       Displays normal or flicker VEF files\r");
    exit(1);
  }
  if (argc==3)
    pauselen=vg_atoi(argv[2]);
  for (scrnum=0;scrnum<=1;++scrnum) {
    if (scrnum==0) {
      if ((file=open(argv[1],1))==-1) {
        writestr(2,"Cannot open ");
        writestr(2,argv[scrnum+1]);
        writestr(2,"\r");
        exit(errno);
      }
      winfile1=newwin();
      groupnum=vg_procid();
      bufnum=1;
      getblk(groupnum,bufnum,0);
      flushwin();
      if ((gpbufptr=vg_mapgpb(winfile1,groupnum,bufnum,1))==NULL)
        exit(errno);
    } else {
      if (strlen(argv[1])>125) exit(1);
      strcpy(newname,argv[1]);
      strcat(newname,".2");
      if ((file=open(newname,1))==-1)
        break;
      flicker=1;
      winfile2=newwin();
    }
    read(file,&c,1);
    read(file,&c,1);
    for (x=0;x<16;++x) {
      read(file,&c,1);
      palette(x,c);
    }
    for (x=0;x<8;++x)
      read(file,gpbufptr,160);
    for (x=0;x<192;++x) {
      read(file,gpbufptr,160);
      putblk(groupnum,bufnum,x);
      flushwin();
    }
  }
  if (flicker) {
    pauselen*=30;
    for (;;) {
      actwin=winfile1;
      vg_select();
      flushwin();
      vg_sleep(2);
      if (vg_ready(winfile1)) {
        read(winfile1,&c,1);
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
    if (pauselen>=0) {
      if (pauselen>0)
        vg_sleep(60*pauselen);
    } else {
      do {
        read(winfile1,&c,1);
      } while (c!=13);
    }
  }
  vg_mapgpb(winfile1,groupnum,bufnum,0);
  actwin=1;
  vg_select();
  flushwin();
  close(winfile1);
  if (flicker)
    close(winfile2);
  return 0;
}

int vg_sleep(int ticks)
{
  registers_6809 r;
  memset(&r,0,sizeof(r));
  r.x=ticks;
  return _os_syscall(0x0a,&r);
}

int newwin(void)
{
  int winfile,windesc;

  windesc=vg_attach("w");
  if ((winfile=open("/w",3))==-1)
    exit(errno);
  actwin=winfile;
  dwset(8);
  curoff();
  vg_select();
  flushwin();
  vg_detach(windesc);
  return(winfile);
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

int vg_select(void)
{
  static char outstr[]={
    0x1b,0x21
  };

  writemem(outstr,sizeof(outstr));
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

int vg_ready(int path)
{
  return _gs_rdy(path)>0;
}

int vg_procid(void)
{
  return getpid();
}

/* Keep diagnostics out of the formatted-I/O runtime. */
int writestr(int file, char *str)
{
  return write(file,str,strlen(str));
}

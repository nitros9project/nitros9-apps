/* OS-9 calls and CoWin control sequences shared by all supported compilers. */
#include "sled_port.h"
static int status(int result)
{
 if(result) {errno=result;return -1;}
 return 0;
}
int sled_os9(int code,struct sled_regs *r)
{
 registers_6809 n;int result;
 memset(&n,0,sizeof(n));n.a=r->rg_a;n.b=r->rg_b;n.x=r->rg_x;n.y=r->rg_y;
 result=_os_syscall(code,&n);
 r->rg_a=n.a;r->rg_b=n.b;r->rg_x=n.x;r->rg_y=n.y;
 return status(result);
}
static int options(int call,int code,int path,void *buf)
{
 registers_6809 r;
 memset(&r,0,sizeof(r));r.a=path;r.b=code;r.x=(int)buf;
 return status(_os_syscall(call,&r));
}
int slgetopt(int code,int path,void *buf) {return options(0x8d,code,path,buf);}
int slsetopt(int code,int path,void *buf) {return options(0x8e,code,path,buf);}
int _gs_palt(int path,char *pal) {return options(0x8d,0x91,path,pal);}
int _gs_styp(int path,int *type)
{
 registers_6809 r;int rc;
 memset(&r,0,sizeof(r));r.a=path;r.b=0x93;rc=_os_syscall(0x8d,&r);
 *type=(int)r.a & 255;return status(rc);
}
int _gs_fbrg(int path,int *fg,int *bg,int *border)
{
 registers_6809 r;int rc;
 memset(&r,0,sizeof(r));r.a=path;r.b=0x96;rc=_os_syscall(0x8d,&r);
 *fg=(int)r.a & 255;*bg=(int)r.b & 255;*border=r.x;return status(rc);
}
static int emit(int path,char *bytes,int count)
{
 fflush(stdout);fflush(stderr);
 return write(path,bytes,count)==count ? 0 : -1;
}
static int control(int path,int first,int second)
{
 char b[2];b[0]=first;b[1]=second;return emit(path,b,2);
}
static int color(int path,int command,int value)
{
 char b[3];b[0]=27;b[1]=command;b[2]=value;return emit(path,b,3);
}
int CurXY(int path,int x,int y)
{
 char b[3];b[0]=2;b[1]=x+32;b[2]=y+32;return emit(path,b,3);
}
int CurOn(int p) {return control(p,5,33);}
int CurOff(int p) {return control(p,5,32);}
int InsLin(int p) {return control(p,31,48);}
int DelLin(int p) {return control(p,31,49);}
int OWEnd(int p) {return control(p,27,35);}
int FColor(int p,int c) {return color(p,50,c);}
int BColor(int p,int c) {return color(p,51,c);}
int Border(int p,int c) {return color(p,52,c);}
int Palette(int p,int i,int c)
{
 char b[4];b[0]=27;b[1]=49;b[2]=i;b[3]=c;return emit(p,b,4);
}
int CWArea(int p,int x,int y,int w,int h)
{
 char b[6];b[0]=27;b[1]=37;b[2]=x;b[3]=y;b[4]=w;b[5]=h;return emit(p,b,6);
}
int OWSet(int p,int save,int x,int y,int w,int h,int fg,int bg)
{
 char b[9];b[0]=27;b[1]=34;b[2]=save;b[3]=x;b[4]=y;b[5]=w;b[6]=h;b[7]=fg;b[8]=bg;return emit(p,b,9);
}
/* Do not overwrite a recovery file left by an earlier editing session. */
int sled_temp(char *name)
{
 registers_6809 r;int pid,i,path,rc;
 memset(&r,0,sizeof(r));_os_syscall(0x0c,&r);pid=(int)r.a & 255;
 strcpy(name,"sledtmp.000a");name[8]='0'+pid/100;name[9]='0'+pid/10%10;name[10]='0'+pid%10;
 for(i=0;i<26;++i) {
  name[11]='a'+i;rc=_os_open(name,1,&path);
  if(rc==216) return 0;
  if(rc==0) _os_close(path);
  else return -1;
 }
 return -1;
}
void sled_sleep(int ticks) {_os9_sleep(&ticks);}

/* Editing keys must use I$Read; stdio may use line-oriented SCF reads. */
int sled_key(void)
{
 char c;int count,rc;
 /* Raw reads bypass stdio: display complete prompts before waiting. */
 fflush(stdout);fflush(stderr);
 count=1;rc=_os_read(0,&c,&count);
 if(rc || count!=1) return EOF;
 return ((int)c)&255;
}

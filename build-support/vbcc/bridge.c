#include "cmoc_os9.h"
struct syscall_request {unsigned code; registers_6809 *regs;};
int vbcall(int code,registers_6809 *regs);
int __cmoc_syscall(struct syscall_request *q) {return vbcall(q->code,q->regs);}
int cmoc_os9_get_user(int *uid) {return cmoc_os_getuid(uid);}
int cmoc_os9_set_user(unsigned int uid) {return cmoc_os_asetuid(uid);}
int cmoc_os9_read_line(int p,void *buf,int *count) {return cmoc_os_readln(p,buf,count);}
typedef char check_regs[sizeof(registers_6809)==12 ? 1 : -1];
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern FILE *__firstfile,*__lastfile;
int fileno(FILE *f) {return f->filehandle;}
FILE *fdopen(int fd,const char *mode)
{
 FILE *f=calloc(1,sizeof(*f));
 if(!f) return 0;
 f->filehandle=fd;
 f->flags=(*mode=='r' ? _READABLE : _WRITEABLE);
 if(strchr(mode,'+')) f->flags|=_READABLE|_WRITEABLE;
 f->clebuf=-1;
 f->prev=__lastfile;
 if(__lastfile) __lastfile->next=f;else __firstfile=f;
 __lastfile=f;
 return f;
}
FILE *vb_raw_fopen(const char *name,const char *mode)
{
 FILE *f=fopen(name,mode);
 if(f) f->flags &= ~_CLE;
 return f;
}
int unlink(const char *s) {return cmoc_os_delete(s,0) ? -1 : 0;}
int chdir(const char *s)
{
 registers_6809 r={0};r.a=3;r.x=(unsigned)s;
 return cmoc_os_syscall(0x86,&r) ? -1 : 0;
}
int getpid(void) {int pid;return cmoc_os_getpid(&pid) ? -1 : pid;}
int setuid(int uid) {return cmoc_os_setuid(uid) ? -1 : 0;}
void _exit(int status) {registers_6809 r={0};r.b=status;cmoc_os_syscall(6,&r);}

extern const unsigned char __ehdr[];
char *vb_progname(void)
{
 static char name[32];const unsigned char *m,*p;int i;
 m=__ehdr-13;p=m+((unsigned)m[4]*256+m[5]);
 for(i=0;i<31;++i) {name[i]=p[i]&127;if(p[i]&128) {++i;break;}}
 name[i]=0;return name;
}
void *unbrk(int n) {void *p=sbrk(-n);return p==(void *)-1 ? 0 : p;}
#include <stdarg.h>
int _os9(int code,struct registers *r)
{
 registers_6809 regs;int result;
 memset(&regs,0,sizeof(regs));memcpy(&regs,r,10);
 result=cmoc_os_syscall(code,&regs);memcpy(r,&regs,10);
 return result ? -1 : 0;
}

int getime(void *p) {return cmoc_os_getime((struct os_time *)p) ? -1 : 0;}
int vb_getstat(int code,int path,...)
{
 va_list ap;void *p;
 if(code==1) return _gs_rdy(path);
 va_start(ap,path);p=va_arg(ap,void *);va_end(ap);
 return cmoc_os_getstat(code,path,p,0) ? -1 : 0;
}
int vb_setstat(int code,int path,...)
{
 va_list ap;void *p=0;
 if(code==0) {va_start(ap,path);p=va_arg(ap,void *);va_end(ap);}
 return cmoc_os_setstat(code,path,p,0,0) ? -1 : 0;
}

int vb_findstr(int start,const char *s,const char *pattern)
{
 const char *p;
 if(start<1 || start-1>strlen(s)) return 0;
 p=strstr(s+start-1,pattern);return p ? p-s+1 : 0;
}
int kill(int pid,int sig) {return cmoc_kill(pid,sig);}
int sleep(int sec) {return cmoc_sleep(sec);}
char *mktemp(char *s)
{
 char *p=strchr(s,'X'),*q;unsigned n;
 if(!p) return s;
 for(q=p;*q=='X';++q) ;
 n=getpid();while(q>p) {*--q='0'+n%10;n/=10;}
 return s;
}
int uucpbb_open(const char *s,int mode) {return cmoc_open(s,mode);}
int uucpbb_access(const char *s,int mode) {return cmoc_access(s,mode);}
int uucpbb_creat(const char *s,int attr) {int p;return cmoc_os_create(s,2,&p,attr) ? -1 : p;}
int uucpbb_mknod(const char *s,int attr) {return cmoc_mknod(s,attr);}
int uucpbb_compare(const void *a,const void *b) {return strucmp(a,b);}
time_t uucpbb_time(time_t *value)
{
 struct os_time now;time_t result;
 if(cmoc_os_getime(&now)) return (time_t)-1;
 result=o2utime(&now);if(value) *value=result;return result;
}
char *uucpbb_ctime(const time_t *value) {struct tm *t=gmtime(value);return t ? asctime(t) : 0;}
FILE *uucpbb_popen(const char *s,const char *mode) {return cmoc_popen(s,mode);}
int uucpbb_pclose(FILE *f) {return cmoc_pclose(f);}
int uucpbb_chown(const char *s,unsigned owner)
{
 struct fildes fd;int p,rc;
 if(cmoc_os_open(s,2,&p) && cmoc_os_open(s,130,&p)) return -1;
 rc=_gs_gfd(p,&fd,sizeof(fd));
 if(!rc) {fd.fd_own=owner;rc=_ss_pfd(p,&fd);}
 cmoc_os_close(p);return rc;
}

int vb_ss_size(int p,unsigned long size) {return _ss_size(p,(void *)(unsigned)(size>>16),(void *)(unsigned)size) ? -1 : 0;}

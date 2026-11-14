#include "llvm.h"
#include <os9.h>
#include <unistd.h>
#include <stddef.h>
struct process_args {
    const char *name;
    const void *params;
    unsigned length;
    unsigned char typelang, pages, pid;
};
typedef char process_layout_check[(offsetof(struct process_args, params)==2 &&
    offsetof(struct process_args, length)==4 && offsetof(struct process_args, typelang)==6 &&
    offsetof(struct process_args, pages)==7 && offsetof(struct process_args, pid)==8) ? 1 : -1];
int __uucp_fork(struct process_args *);
int __uucp_chain(struct process_args *);
void __uucp_signal_receiver(void);
static int (*signal_handler)(int);
char *uucpbb_module_name(const char *);
char *uucpbb_parameters(const void *, int);
static int run_process(const char *name, int length, const void *params,
                       int type, int language, int pages, int chained)
{
    struct process_args p;
    char *module=uucpbb_module_name(name), *arguments;
    int code;
    if (!module) return -1;
    arguments=uucpbb_parameters(params,length);
    if (!arguments) { free(module); return -1; }
    p.name=module; p.params=arguments; p.length=length;
    p.typelang=(type<<4)|language; p.pages=pages; p.pid=0;
    code=chained ? __uucp_chain(&p) : __uucp_fork(&p);
    free(arguments); free(module);
    if (code) { __os9_fail(code); return -1; }
    return p.pid;
}
int os9fork(const char *name, int length, const void *params, int type, int language, int pages)
{
    return run_process(name,length,params,type,language,pages,0);
}
int chain(const char *name, int length, const void *params, int type, int language, int pages)
{
    return run_process(name,length,params,type,language,pages,1);
}
int wait(int *status)
{
    unsigned char failed, code, pid;
    OS9_SYSCALL(0x04, ("=c"(failed), "=B"(code), "=A"(pid)), ());
    if (failed) { __os9_fail(code); return -1; }
    if (status) *status = code;
    return pid;
}
int setpr(int pid, int priority)
{
    unsigned char failed, code;
    OS9_SYSCALL(0x0d, ("=c"(failed), "=B"(code)), ("A"((unsigned char)pid), "B"((unsigned char)priority)));
    return failed ? (__os9_fail(code), -1) : 0;
}
int intercept(int (*handler)(int))
{
    unsigned char failed, code;
    signal_handler = handler;
    OS9_SYSCALL(0x09, ("=c"(failed), "=B"(code)), ("x"(__uucp_signal_receiver)));
    return failed ? (__os9_fail(code), -1) : 0;
}
void uucpbb_dispatch_signal(int signal)
{
    if (signal_handler) signal_handler(signal);
}
int tsleep(unsigned ticks) { return _os_sleep(ticks) ? -1 : 0; }
unsigned sleep(unsigned seconds)
{
    while (seconds--) if (_os_sleep(60)) return seconds+1;
    return 0;
}
int dup(int path)
{
    int result;
    return _os_dup(path, &result) ? -1 : result;
}
int setuid(uid_t uid) { return asetuid(uid); }
int system(const char *command)
{
    char *params;
    int length, pid, child, status;
    if (!command) return uucpbb_access("shell", OS9_EXEC)==0;
    length = strlen(command);
    params = malloc(length+2);
    if (!params) return -1;
    memcpy(params,command,length);
    params[length++]='\r'; params[length]=0;
    pid = os9fork("shell",length,params,1,1,0);
    free(params);
    if (pid < 0) return -1;
    while ((child=wait(&status))>=0) if (child==pid) return status;
    return -1;
}

#ifndef APPS_VBCC_SIGNAL_H
#define APPS_VBCC_SIGNAL_H
typedef volatile int sig_atomic_t;
typedef void (*vb_sighandler_t)(int);
vb_sighandler_t signal(int,vb_sighandler_t);
int raise(int);
#define SIGKILL 0
#define SIGWAKE 1
#define SIGQUIT 2
#define SIGINT 3
#define SIGTERM 0
#define SIGABRT 2
#define SIGFPE 2
#define SIGILL 2
#define SIGSEGV 2
#define SIG_DFL ((vb_sighandler_t)0)
#define SIG_IGN ((vb_sighandler_t)1)
#define SIG_ERR ((vb_sighandler_t)-1)
#endif

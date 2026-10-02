/* Register-native OS-9 path-status adapters. */
#include <errno.h>
#include <os9.h>
#include "sgstat.h"
#include <stddef.h>
typedef char fd_layout_check[(offsetof(struct fildes, fd_own)==1 && sizeof(struct fildes)==256) ? 1 : -1];
typedef char scf_layout_check[sizeof(struct sgbuf)==32 ? 1 : -1];
int _gs_gfd(int path, void *buf, int n) { return _os_getstt_buf(path, OS9_SS_FD, buf, n) ? -1 : 0; }
int _ss_pfd(int path, const void *buf) { return _os_setstt_buf(path, OS9_SS_FD, buf, 0) ? -1 : 0; }
int _gs_opt(int path, void *buf) { return _os_getstt_buf(path, OS9_SS_OPT, buf, 32) ? -1 : 0; }
int _ss_opt(int path, const void *buf) { return _os_setstt_buf(path, OS9_SS_OPT, buf, 0) ? -1 : 0; }
int _gs_devn(int path, char *buf) { return _os_getstt_buf(path, OS9_SS_DEVNM, buf, 32) ? -1 : 0; }
int _ss_attr(int path, int attrs) { return _os_setstt_buf(path, 0x1c, (void *)attrs, 0) ? -1 : 0; }
int _ss_ssig(int path, int signal) { return _os_setstt_buf(path, 0x1a, (void *)signal, 0) ? -1 : 0; }
int _ss_rel(int path) { return _os_setstt_buf(path, 0x1b, 0, 0) ? -1 : 0; }
int _gs_rdy(int path)
{
    unsigned char failed, result;
    OS9_SYSCALL(OS9_I_GETSTT, ("=c"(failed), "=B"(result)), ("A"((unsigned char)path), "B"((unsigned char)OS9_SS_READY)));
    if (failed) { __os9_fail(result); return -1; }
    return result;
}
long _gs_pos(int path)
{
    struct __os9_xu r = { (unsigned char)path, OS9_SS_POS, 0 };
    return __os9_getstt_xu(&r) ? -1L : (long)r.pos;
}
int _ss_size(int path, unsigned long size)
{
    struct __os9_xu r = { (unsigned char)path, OS9_SS_SIZE, size };
    return __os9_setstt_xu(&r) ? -1 : 0;
}
int uucpbb_chown(const char *name, unsigned owner)
{
    struct fildes fd;
    int path, status;
    if (_os_open(name, OS9_WRITE, &path) && _os_open(name, OS9_WRITE|OS9_DIR, &path)) return -1;
    status = _gs_gfd(path, &fd, sizeof(fd));
    if (status == 0) { fd.fd_own = owner; status = _ss_pfd(path, &fd); }
    _os_close(path);
    return status;
}

/* Only the legacy register calls used by UUCPbb are exposed here. */
#include "llvm.h"
#include <os9.h>
#include <stddef.h>
typedef char registers_layout_check[offsetof(struct registers, rg_x)==4 ? 1 : -1];
int __uucp_nmlink(struct registers *);
int __uucp_nmload(struct registers *);
int __uucp_munload(struct registers *);
int _os9(int service, struct registers *r)
{
    unsigned char failed, code;
    unsigned x, y;
    int result;
    switch (service) {
    case 0x21: result = __uucp_nmlink(r); break;
    case 0x22: result = __uucp_nmload(r); break;
    case 0x1d: result = __uucp_munload(r); break;
    case I_GETSTT:
        OS9_SYSCALL(OS9_I_GETSTT, ("=c"(failed), "=B"(code), "=x"(x), "=y"(y)),
                    ("A"(r->rg_a), "B"(r->rg_b)));
        r->rg_x = x; r->rg_y = y;
        result = failed ? code : 0;
        break;
    case I_SETSTT:
        OS9_SYSCALL(OS9_I_SETSTT, ("=c"(failed), "=B"(code)),
                    ("A"(r->rg_a), "B"(r->rg_b)));
        result = failed ? code : 0;
        break;
    default: result = OS9_E_UNKSVC;
    }
    r->rg_b = result;
    if (result) { __os9_fail(result); return -1; }
    return 0;
}
int getstat(int fn, int path, void *buf)
{
    return _os_getstt_buf(path, fn, buf, 32) ? -1 : 0;
}
int setstat(int fn, int path)
{
    return _os_setstt_buf(path, fn, 0, 0) ? -1 : 0;
}

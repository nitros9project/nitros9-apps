/* Legacy file size and error reporting adapters. */
#include <errno.h>
#include <os9.h>

long _gs_size(int path)
{
    struct __os9_xu request = { (unsigned char)path, OS9_SS_SIZE, 0 };
    return __os9_getstt_xu(&request) == 0 ? (long)request.pos : -1L;
}

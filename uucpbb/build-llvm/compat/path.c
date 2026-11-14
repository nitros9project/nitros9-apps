/* Legacy OS-9 path modes must not be passed to POSIX open/access. */
#include <errno.h>
#include <os9.h>
int uucpbb_open(const char *name, int mode)
{
    int path;
    return _os_open(name, mode, &path) ? -1 : path;
}
int uucpbb_creat(const char *name, int attrs)
{
    int path;
    return _os_create(name, OS9_WRITE, attrs, &path) ? -1 : path;
}
int uucpbb_access(const char *name, int mode)
{
    int path = uucpbb_open(name, mode ? mode : OS9_READ);
    if (path < 0) return -1;
    return _os_close(path) ? -1 : 0;
}
int uucpbb_mknod(const char *name, int attrs)
{
    return _os_makdir(name, attrs) ? -1 : 0;
}
int create(const char *name, int mode, int attrs)
{
    int path;
    return _os_create(name, mode, attrs, &path) ? -1 : path;
}
int chxdir(const char *name) { return _os_chgdir(name, OS9_EXEC) ? -1 : 0; }
int writeln(int path, const void *buffer, int count)
{
    return _os_writeln(path, buffer, &count) ? -1 : count;
}

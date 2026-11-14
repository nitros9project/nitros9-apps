/* Normalize legacy C text before passing it to the kernel's F$Fork/F$Chain. */
#include <errno.h>
#include <stdlib.h>
#include <string.h>
char *uucpbb_module_name(const char *name)
{
    size_t length;
    char *copy;
    if (!name || !(length=strcspn(name,"\r\n"))) { errno=EINVAL; return 0; }
    copy=malloc(length+1);
    if (copy) { memcpy(copy,name,length); copy[length]=0; }
    return copy;
}
char *uucpbb_parameters(const void *params, int length)
{
    char *copy;
    if (length<0 || (length && !params)) { errno=EINVAL; return 0; }
    copy=malloc((size_t)length+1);
    if (!copy) return 0;
    if (length) memcpy(copy,params,length);
    if (length && copy[length-1]=='\n') copy[length-1]='\r';
    copy[length]=0;
    return copy;
}

/* Kreider-compatible formatted error reporting. */
#include <stdio.h>
#include <stdarg.h>

int _errmsg(int code, const char *format, ...)
{
    va_list args;
    va_start(args, format);
    vfprintf(stderr, format, args);
    va_end(args);
    fprintf(stderr, "error %d\n", code);
    return code;
}

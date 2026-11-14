/* Legacy Kreider string functions, implemented using the C library. */
#include <string.h>
#include <strings.h>
char *strend(char *s) { return s + strlen(s); }
int strucmp(const char *a, const char *b) { return strcasecmp(a, b); }
int strnucmp(const char *a, const char *b, unsigned int n)
{
    return strncasecmp(a, b, n);
}

int uucpbb_compare(const void *a, const void *b) { return strcasecmp(a,b); }
int findstr(int start, const char *hay, const char *needle)
{
    const char *p;
    if (start < 1 || (unsigned)(start-1) > strlen(hay)) return 0;
    p = strstr(hay + start - 1, needle);
    return p ? (int)(p - hay) + 1 : 0;
}

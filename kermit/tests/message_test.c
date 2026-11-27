#include "message.h"
#include <assert.h>
#include <limits.h>
#include <stdio.h>
#include <string.h>

static int format(char *out, int capacity, const char *fmt, ...)
{
    int result;
    va_list args;
    va_start(args, fmt);
    result = kermit_vformat(out, capacity, fmt, args);
    va_end(args);
    return result;
}

int main(void)
{
    char out[128], expected[32];
    struct { char before; char out[5]; char after; } bounded = {'L', "", 'R'};
    assert(format(out, sizeof(out), "Receiving %s as %s", "A.TXT", "a.txt") == 24);
    assert(strcmp(out, "Receiving A.TXT as a.txt") == 0);
    format(out, sizeof(out), "Error #%03d, Writing to %s", 7, "file");
    assert(strcmp(out, "Error #007, Writing to file") == 0);
    format(out, sizeof(out), "%03d %d %%", -7, 0);
    assert(strcmp(out, "-07 0 %") == 0);
    sprintf(expected, "%d", INT_MIN);
    format(out, sizeof(out), "%d", INT_MIN);
    assert(strcmp(out, expected) == 0);
    assert(format(bounded.out, sizeof(bounded.out), "%s:%03d", "abcdef", 7) == 4);
    assert(strcmp(bounded.out, "abcd") == 0);
    assert(bounded.before == 'L' && bounded.after == 'R');
    assert(format(out, 1, "text") == 0 && out[0] == 0);
    assert(format(NULL, 0, "text") == 0);
    format(out, sizeof(out), "%s", (char *)NULL);
    assert(strcmp(out, "(null)") == 0);
    format(out, sizeof(out), "trailing %");
    assert(strcmp(out, "trailing %") == 0);
    puts("Kermit message formatting passed");
    return 0;
}

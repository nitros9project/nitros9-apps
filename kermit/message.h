#ifndef KERMIT_MESSAGE_H
#define KERMIT_MESSAGE_H
#include <stdarg.h>
/* Message formats used by Kermit: %s, %d, %03d and %%. Always NUL-terminates
   when capacity is positive, and returns the number of stored characters. */
int kermit_vformat(char *out, int capacity, const char *fmt, va_list args);
#endif

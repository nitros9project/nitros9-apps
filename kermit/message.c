#include "message.h"

int kermit_vformat(char *out, int capacity, const char *fmt, va_list args)
{
    int used = 0, width, zero, value, count, negative;
    unsigned magnitude;
    char digits[16], *text, *end;
    if (capacity <= 0)
        return 0;
    while (*fmt)
    {
        if (*fmt != '%')
        {
            if (used < capacity - 1) out[used++] = *fmt;
            ++fmt;
            continue;
        }
        ++fmt;
        zero = (*fmt == '0');
        width = 0;
        while (*fmt >= '0' && *fmt <= '9')
        {
            if (width < 80) width = width * 10 + *fmt - '0';
            ++fmt;
        }
        if (*fmt == 's')
        {
            text = va_arg(args, char *);
            if (!text) text = "(null)";
        }
        else if (*fmt == 'd')
        {
            value = va_arg(args, int);
            negative = value < 0;
            magnitude = negative ? 0u - (unsigned)value : (unsigned)value;
            end = digits + sizeof(digits) - 1;
            *end = 0;
            do { *--end = '0' + magnitude % 10; magnitude /= 10; } while (magnitude);
            if (negative) *--end = '-';
            text = end;
            count = (int)(digits + sizeof(digits) - 1 - end);
            if (negative && zero && width > count)
            {
                if (used < capacity - 1) out[used++] = *text;
                ++text;
            }
            while (width-- > count)
                if (used < capacity - 1) out[used++] = zero ? '0' : ' ';
        }
        else if (*fmt == '%')
        {
            digits[0] = '%'; digits[1] = 0; text = digits;
        }
        else
        {
            /* Preserve an unsupported conversion rather than consume a
               variadic argument of an unknown type. */
            if (used < capacity - 1) out[used++] = '%';
            if (*fmt && used < capacity - 1) out[used++] = *fmt;
            if (*fmt) ++fmt;
            continue;
        }
        while (*text)
        {
            if (used < capacity - 1) out[used++] = *text;
            ++text;
        }
        ++fmt;
    }
    out[used] = 0;
    return used;
}

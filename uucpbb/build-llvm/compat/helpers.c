#include <ctype.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
char *strhcpy(char *dest, const char *source)
{
    char *start = dest;
    unsigned char c;
    do { c = *source++; *dest++ = c & 0x7f; } while (!(c & 0x80) && c);
    *dest = 0;
    return start;
}
long htol(const char *s) { return (long)strtoul(s, 0, 16); }
int min(int a, int b) { return a < b ? a : b; }
int max(int a, int b) { return a > b ? a : b; }
int crc(const void *buffer, int length, unsigned char state[3])
{
    const unsigned char *p = buffer;
    uint32_t value = ((uint32_t)state[0]<<16) | ((uint32_t)state[1]<<8) | state[2];
    int bit;
    while (length-- > 0) {
        value ^= (uint32_t)*p++ << 16;
        for (bit=0; bit<8; bit++) {
            value <<= 1;
            if (value & 0x1000000UL) value ^= 0x800063UL;
            value &= 0xffffffUL;
        }
    }
    state[0] = value >> 16; state[1] = value >> 8; state[2] = value;
    return 0;
}
int patmatch(const char *pattern, const char *text, int fold_case)
{
    while (*pattern) {
        unsigned char pc = *pattern++, tc;
        if (pc == '*') {
            do { if (patmatch(pattern, text, fold_case)) return 1; } while (*text++);
            return 0;
        }
        if (!*text) return 0;
        tc = *text++;
        if (pc == '?') continue;
        if (fold_case) { pc = toupper(pc); tc = toupper(tc); }
        if (pc != tc) return 0;
    }
    return *text == 0;
}

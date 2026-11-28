#include <stdio.h>
unsigned height = 192;
int start = 0, magnification = 1;
int rows[192];
void maprows(int);
int main(void)
{
    int i;
    for (i = 0; i < 192; ++i) rows[i] = -1;
    maprows(192);
    for (i = 0; i < 192; ++i)
        if (rows[i] != i) {
            puts("ACCUMULATOR RESTORE FAIL");
            return 1;
        }
    puts("ACCUMULATOR RESTORE PASS");
    return 0;
}

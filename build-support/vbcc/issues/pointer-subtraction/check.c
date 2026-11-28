#include <stdio.h>
struct record {
    char *text;
    unsigned length;
    char *key;
    unsigned key_length;
};
static struct record records[8];
struct record *top;
unsigned count;
void put_record(char *, unsigned);
int main(void)
{
    char *text = "sample";
    top = records + 8;
    count = 1;
    put_record(text, 6);
    if (records[6].text != text || records[6].length != 6) {
        puts("POINTER SUBTRACTION FAIL");
        return 1;
    }
    puts("POINTER SUBTRACTION PASS");
    return 0;
}

#include <stdio.h>
int farfun(void);
int main(void)
{
 if(farfun()!=4660) return 1;
 puts("PCREL WRAP PASS");return 0;
}

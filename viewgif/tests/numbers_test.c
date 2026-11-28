#include "port.h"

int main(void)
{
  static char *texts[]={"", "0", "16", "300", "-1", "+42", " \t-17tail", "32767", "-32768", "garbage"};
  static int values[]={0,0,16,300,-1,42,-17,32767,-32768,0};
  int i;
  for (i=0;i<10;++i) if (vg_atoi(texts[i])!=values[i]) return i+1;
  return 0;
}

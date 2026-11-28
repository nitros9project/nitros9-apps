/* These command-line options need decimal integers, not strtol's long parsing. */
#include "port.h"

int vg_atoi(char *text)
{
  unsigned value=0;
  int negative=0;
  while (*text==' ' || (*text>='\t' && *text<='\r')) ++text;
  if (*text=='+' || *text=='-') negative=(*text++=='-');
  while (*text>='0' && *text<='9') value=value*10+(*text++-'0');
  return (int)(negative ? 0-value : value);
}

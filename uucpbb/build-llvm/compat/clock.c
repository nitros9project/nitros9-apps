/* OS-9 Clock packets are wall-clock values. UUCPbb supplies the timezone
 * label through Parameters; no host-style timezone database is consulted. */
#include "llvm.h"
#include <os9.h>
static int leap(int year) { return !(year%4) && (year%100 || !(year%400)); }
static time_t packet_epoch(const struct sgtbuf *date)
{
    static const unsigned char lengths[12]={31,28,31,30,31,30,31,31,30,31,30,31};
    long days=0;
    int year=1900+date->t_year, y, month;
    if (date->t_month<1 || date->t_month>12 || date->t_day<1 ||
        date->t_day>lengths[date->t_month-1]+(date->t_month==2 && leap(year)) ||
        date->t_hour>23 || date->t_minute>59 || date->t_second>59) {
        errno=EINVAL; return (time_t)-1;
    }
    for (y=1970; y<year; y++) days+=365+leap(y);
    for (y=year; y<1970; y++) days-=365+leap(y);
    for (month=1; month<date->t_month; month++) days+=lengths[month-1]+(month==2 && leap(year));
    days+=date->t_day-1;
    return (time_t)days*86400 + (time_t)date->t_hour*3600 + date->t_minute*60 + date->t_second;
}
int getime(struct sgtbuf *date) { return _os_time((unsigned char *)date) ? -1 : 0; }
long o2utime(const struct sgtbuf *date) { return (long)packet_epoch(date); }
time_t uucpbb_time(time_t *result)
{
    struct sgtbuf date;
    time_t value;
    if (getime(&date)) return (time_t)-1;
    value=packet_epoch(&date);
    if (result) *result=value;
    return value;
}
char *uucpbb_ctime(const time_t *value)
{
    struct tm *date=gmtime(value);
    return date ? asctime(date) : 0;
}

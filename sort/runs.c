/*
 * runs.c - temporary files, buffered output and cleaning up.
 *
 * Runs go in /r0 unless -T names another directory; if /r0 cannot be
 * used they go in the current data directory instead.  Temporary files
 * are named sort<pid>.<n>.  A signal only sets a flag, which the read,
 * write and merge loops check, so files are closed before they are
 * deleted.
 */

#include "sort.h"

#define E_FULL  248     /* E$Full: device full */
#define OBUFSIZ 1024
#define DEFTDIR "/r0"

struct run runs[MAXRUNS];
int nruns;

static int pid;
static int nextid = 1;
static int tdirset;     /* the temporary directory has been chosen */
static int wid;         /* run being written, or 0 */

static int wfd = -1;
static int wscf;        /* writing to an SCF device such as a terminal */
static char *wname;     /* what is being written, for messages */
static char obuf[OBUFSIZ];
static unsigned on;
long wbytes;            /* bytes written by the current writer */

static int
catcher(sig)
int sig;
{
        aborted = sig;
        return 0;
}

int
initruns()
{
        pid = getpid();
        intercept(catcher);
        return 0;
}

static int
tmpname(id, buf)
int id;
char *buf;
{
        sprintf(buf, "%s/sort%d.%d", tdir, pid, id);
        return 0;
}

/* create the next run file; returns its path number */
int
newrun(idp)
int *idp;
{
        char name[TNAMSIZ];
        int fd;

        wid = *idp = nextid++;
        if (!tdirset) {
                tdirset = 1;
                if (tdir == NULL) {
                        tdir = DEFTDIR;
                        tmpname(wid, name);
                        if ((fd = creat(name, 3)) >= 0) {
                                if (vflag)
                                        fprintf(stderr,
                                        "sort: temporary files in %s\n",
                                                tdir);
                                return fd;
                        }
                        fprintf(stderr,
                        "sort: can't use %s for temporary files, using .\n",
                                DEFTDIR);
                        tdir = ".";
                } else if (vflag)
                        fprintf(stderr, "sort: temporary files in %s\n",
                                tdir);
        }
        tmpname(wid, name);
        if ((fd = creat(name, 3)) < 0) {
                fprintf(stderr, "sort: can't create %s (error %d)\n",
                        name, errno);
                fail(ERRCODE);
        }
        return fd;
}

int
openrun(id)
int id;
{
        char name[TNAMSIZ];
        int fd;

        tmpname(id, name);
        if ((fd = open(name, 1)) < 0) {
                fprintf(stderr, "sort: can't open %s (error %d)\n",
                        name, errno);
                fail(ERRCODE);
        }
        return fd;
}

int
killrun(id)
int id;
{
        char name[TNAMSIZ];

        tmpname(id, name);
        unlink(name);
        return 0;
}

/* close every path a temporary file might be using, then delete the
   temporary files */
int
cleanup()
{
        register int i;

        for (i = 3; i < 16; i++)
                close(i);
        if (tdirset) {
                for (i = 0; i < nruns; i++)
                        killrun(runs[i].id);
                if (wid)
                        killrun(wid);
        }
        nruns = 0;
        wid = 0;
        return 0;
}

int
fail(code)
int code;
{
        cleanup();
        exit(code);
        return code;
}

int
checkabort()
{
        if (aborted) {
                fprintf(stderr, "sort: interrupted (signal %d)\n", aborted);
                fail(aborted);
        }
        return 0;
}

/* write len bytes at p: a line ending in CR goes to an SCF device with
   writeln, which adds the line feed a terminal needs */
static int
wout(p, len)
char *p;
unsigned len;
{
        if (wscf && len > 0 && p[len - 1] == CR)
                return writeln(wfd, p, len);
        return write(wfd, p, len);
}

static int
flush()
{
        register char *p, *s, *e;
        int cnt;

        if (on == 0)
                return 0;
        if (wscf) {
                /* line by line, so each line ends with writeln */
                s = obuf;
                e = obuf + on;
                cnt = 0;
                while (s < e) {
                        for (p = s; p < e && *p != CR; p++)
                                ;
                        if (p < e)
                                p++;
                        if (wout(s, (unsigned)(p - s)) != p - s)
                                break;
                        cnt += p - s;
                        s = p;
                }
        } else
                cnt = write(wfd, obuf, on);
        checkabort();
        if (cnt != on) {
                if (errno == E_FULL)
                        fprintf(stderr, "sort: no space for %s\n", wname);
                else
                        fprintf(stderr, "sort: write error %d on %s\n",
                                errno, wname);
                fail(ERRCODE);
        }
        on = 0;
        return 0;
}

/* start writing to fd; name is for messages */
int
wopen(fd, name)
int fd;
char *name;
{
        char opt[32];

        wfd = fd;
        wname = name;
        on = 0;
        wbytes = 0;
        /* path option byte 0 is the device class: 0 for SCF */
        wscf = getstat(0, fd, opt) != -1 && opt[0] == 0;
        return 0;
}

/* write line t, l and its CR */
int
wput(t, l)
register char *t;
register unsigned l;
{
        wbytes += l + 1;
        while (l) {
                if (on == OBUFSIZ)
                        flush();
                obuf[on++] = *t++;
                l--;
        }
        if (on == OBUFSIZ)
                flush();
        obuf[on++] = CR;
        return 0;
}

/* finish writing; a temporary file is closed and becomes a run */
int
wclose(lines)
long lines;
{
        flush();
        if (wfd > 2)
                close(wfd);
        wfd = -1;
        if (wid) {
                if (nruns >= MAXRUNS) {
                        fprintf(stderr,
                                "sort: too many runs; use a larger -m\n");
                        fail(EX_MEM);
                }
                runs[nruns].id = wid;
                runs[nruns].size = wbytes;
                runs[nruns].lines = lines;
                nruns++;
                wid = 0;
        }
        return 0;
}

/* write the n sorted records in p, dropping repeats with -u; returns
   the lines written */
long
writerecs(p, n)
register struct rec **p;
unsigned n;
{
        register unsigned i;
        long w;

        w = 0;
        for (i = 0; i < n; i++) {
                if (uflag && i > 0 && cmprec(p[i - 1], p[i]) == 0)
                        continue;
                wput(p[i]->t, p[i]->l);
                w++;
        }
        return w;
}

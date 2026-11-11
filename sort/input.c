/*
 * input.c - read lines into the arena.
 *
 * Input is read with read() straight into the arena, in blocks of whole
 * sectors, and split into lines in place, so each byte is copied once.
 * Line text grows up from abase; the records grow down from atop.  Each
 * line also needs two pointers when the arena is sorted, so a line fits
 * only if its record and pointers fit below the records already there.
 */

#include "sort.h"

#define RS      (sizeof(struct rec))
#define PERLINE (RS + 2 * sizeof(struct rec *))
#define BLOCK   2048    /* largest single read */

static char **files;
static int nfiles, nextf;
static int curfd = -1;
static char *curname;

static char *lstart;    /* start of the line being read */
static char *scan;      /* first byte not yet looked at */
static char *tend;      /* end of the bytes read */
static unsigned n;      /* lines in the arena */

int
inopen(nf, fl)
int nf;
char **fl;
{
        nfiles = nf;
        files = fl;
        nextf = 0;
        lstart = scan = tend = abase;
        n = 0;
        return 0;
}

unsigned
nrecs()
{
        return n;
}

struct rec *
recbase()
{
        return (struct rec *)atop - n;
}

/* the first free byte above the text, where the pointer tables go */
char *
textend()
{
        return tend;
}

/* bytes free between the text and the records, after reserving the
   pointer tables for the lines already here and one more line */
static unsigned
freebytes()
{
        unsigned used;

        used = (n + 1) * PERLINE;
        if ((unsigned)(atop - tend) <= used)
                return 0;
        return (unsigned)(atop - tend) - used;
}

/* record the line s, l; 0 if there is no room for it */
static int
addline(s, l)
char *s;
unsigned l;
{
        register struct rec *r;

        if ((unsigned)(atop - tend) < (n + 1) * PERLINE)
                return 0;
        r = (struct rec *)atop - (n + 1);
        r->t = s;
        r->l = l;
        setkey(r);
        n++;
        if (l > maxlen)
                maxlen = l;
        tlines++;
        return 1;
}

static int
nextfile()
{
        curname = files[nextf++];
        if (curname[0] == '-' && curname[1] == '\0')
                curfd = 0;
        else if ((curfd = open(curname, 1)) < 0) {
                fprintf(stderr, "sort: can't open %s (error %d)\n",
                        curname, errno);
                fail(ERRCODE);
        }
        return 0;
}

/* fill the arena; returns 1 when it is full and 0 at the end of the
   input.  A full arena with no lines in it means a line longer than the
   whole arena. */
int
readarena()
{
        register char *p;
        unsigned room;
        int cnt;

        for (;;) {
                /* split what has been read into lines */
                for (p = scan; p < tend; p++)
                        if (*p == CR) {
                                if (!addline(lstart, (unsigned)(p - lstart))) {
                                        scan = p;
                                        return 1;
                                }
                                lstart = p + 1;
                        }
                scan = tend;

                if (curfd < 0) {
                        if (nextf >= nfiles)
                                return 0;
                        nextfile();
                }

                room = freebytes();
                if (room < 256)
                        return 1;
                if (room > BLOCK)
                        room = BLOCK;
                else
                        room &= ~255;
                cnt = read(curfd, tend, room);
                checkabort();
                if (cnt < 0) {
                        fprintf(stderr, "sort: read error %d on %s\n",
                                errno, curname);
                        fail(ERRCODE);
                }
                if (cnt == 0) {
                        /* end of this file: a last line without a CR
                           is still a line */
                        if (lstart < tend) {
                                if (!addline(lstart,
                                             (unsigned)(tend - lstart)))
                                        return 1;
                                lstart = scan = tend;
                        }
                        if (curfd != 0)
                                close(curfd);
                        curfd = -1;
                        continue;
                }
                tbytes += cnt;
                tend += cnt;
        }
}

/* empty the arena, keeping the partial line being read */
int
resetarena()
{
        register char *s, *d;
        unsigned keep;

        keep = (unsigned)(tend - lstart);
        s = lstart;
        d = abase;
        if (s != d)
                while (s < tend)
                        *d++ = *s++;
        scan = abase + (unsigned)(scan - lstart);
        lstart = abase;
        tend = abase + keep;
        n = 0;
        return 0;
}

/*
 * merge.c - merge the runs.
 *
 * Up to MAXFAN runs are merged at once, each through a buffer in the
 * arena big enough for its longest line.  A heap of the runs' current
 * lines picks the next line in about log2 k comparisons; equal lines go
 * to the run that came earlier in the input, so the sort stays stable.
 * For the same reason only adjacent runs are merged together: while
 * there are more runs than can be merged at once, the cheapest adjacent
 * group is merged into one run in its place, and that group is only as
 * large as is needed to leave a final merge of exactly k runs.
 */

#include "sort.h"

struct rdr {
        int fd;
        char *buf;
        unsigned pos, end;
        int eof;
        int order;              /* position of its run in the input */
        struct rec cur;         /* current line */
};

static struct rdr rd[MAXFAN];
static int heap[MAXFAN];
static int hn;
static unsigned bsize;          /* bytes in each run's buffer */
static char *prevbuf;           /* last line written, for -u */
static struct rec prev;
static int haveprev;

/* refill r's buffer after its unread bytes */
static int
rfill(r)
register struct rdr *r;
{
        register char *s, *d;
        unsigned left;
        int cnt;

        left = r->end - r->pos;
        if (r->pos > 0) {
                s = r->buf + r->pos;
                d = r->buf;
                while (s < r->buf + r->end)
                        *d++ = *s++;
                r->pos = 0;
                r->end = left;
        }
        if (r->end >= bsize) {
                fprintf(stderr, "sort: line too long in a run\n");
                fail(EX_MEM);
        }
        cnt = read(r->fd, r->buf + r->end, bsize - r->end);
        checkabort();
        if (cnt < 0) {
                fprintf(stderr, "sort: read error %d on a run\n", errno);
                fail(ERRCODE);
        }
        if (cnt == 0)
                r->eof = 1;
        r->end += cnt;
        return 0;
}

/* move r to its next line; 0 at the end of the run */
static int
rnext(r)
register struct rdr *r;
{
        register char *p, *e, *q;

        for (;;) {
                p = r->buf + r->pos;
                e = r->buf + r->end;
                for (q = p; q < e && *q != CR; q++)
                        ;
                if (q < e) {
                        r->cur.t = p;
                        r->cur.l = (unsigned)(q - p);
                        r->pos = (unsigned)(q + 1 - r->buf);
                        setkey(&r->cur);
                        return 1;
                }
                if (r->eof) {
                        if (p < e) {
                                r->cur.t = p;
                                r->cur.l = (unsigned)(e - p);
                                r->pos = r->end;
                                setkey(&r->cur);
                                return 1;
                        }
                        return 0;
                }
                rfill(r);
        }
}

/* does reader i come before reader j? */
static int
before(i, j)
int i, j;
{
        register int c;

        c = cmprec(&rd[i].cur, &rd[j].cur);
        if (c == 0)
                return rd[i].order < rd[j].order;
        return c < 0;
}

static int
siftdown(i)
register int i;
{
        register int c, t;

        for (;;) {
                c = i + i + 1;
                if (c >= hn)
                        break;
                if (c + 1 < hn && before(heap[c + 1], heap[c]))
                        c++;
                if (!before(heap[c], heap[i]))
                        break;
                t = heap[i];
                heap[i] = heap[c];
                heap[c] = t;
                i = c;
        }
        return 0;
}

/* write r's current line unless -u finds it repeats the last one */
static long
emit(r)
register struct rdr *r;
{
        register char *s, *d;
        register unsigned l;

        if (uflag) {
                if (haveprev && cmprec(&prev, &r->cur) == 0)
                        return 0;
                s = r->cur.t;
                d = prevbuf;
                for (l = r->cur.l; l; l--)
                        *d++ = *s++;
                prev.t = prevbuf;
                prev.l = r->cur.l;
                setkey(&prev);
                haveprev = 1;
        }
        wput(r->cur.t, r->cur.l);
        return 1;
}

/* merge runs[first] .. runs[first + m - 1] to outfd, or into a new run
   in their place if outfd < 0 */
static int
merge(first, m, outfd, outname)
int first, m, outfd;
char *outname;
{
        register int i;
        struct rdr *r;
        struct run nr;
        long lines, next;
        int id;

        id = 0;
        if (outfd < 0) {
                outfd = newrun(&id);
                wopen(outfd, "temporary file");
        } else
                wopen(outfd, outname);
        if (vflag) {
                long bytes;

                bytes = 0;
                for (i = 0; i < m; i++)
                        bytes += runs[first + i].size;
                if (id)
                        fprintf(stderr,
                        "sort: merging runs %d-%d (%ld bytes) into run %d\n",
                                first + 1, first + m, bytes, id);
                else
                        fprintf(stderr,
                        "sort: merging runs %d-%d (%ld bytes) to the output\n",
                                first + 1, first + m, bytes);
        }

        hn = 0;
        haveprev = 0;
        for (i = 0; i < m; i++) {
                r = &rd[i];
                r->fd = openrun(runs[first + i].id);
                r->pos = r->end = 0;
                r->eof = 0;
                r->order = i;
                if (rnext(r))
                        heap[hn++] = i;
        }
        for (i = hn / 2 - 1; i >= 0; i--)
                siftdown(i);

        lines = 0;
        next = 1000;
        while (hn > 0) {
                r = &rd[heap[0]];
                lines += emit(r);
                if (rnext(r))
                        siftdown(0);
                else {
                        heap[0] = heap[--hn];
                        siftdown(0);
                }
                if (vflag && lines >= next) {
                        fprintf(stderr, "sort:   %ld lines\n", lines);
                        next += 1000;
                }
        }
        for (i = 0; i < m; i++)
                close(rd[i].fd);
        wclose(lines);

        /* the old runs are no longer needed */
        for (i = 0; i < m; i++)
                killrun(runs[first + i].id);
        if (id) {
                /* wclose added the new run at the end: put it in their
                   place */
                nr.id = runs[nruns - 1].id;
                nr.size = runs[nruns - 1].size;
                nr.lines = runs[nruns - 1].lines;
                nruns--;
                runs[first].id = nr.id;
                runs[first].size = nr.size;
                runs[first].lines = nr.lines;
                for (i = first + 1; i + m - 1 < nruns; i++) {
                        runs[i].id = runs[i + m - 1].id;
                        runs[i].size = runs[i + m - 1].size;
                        runs[i].lines = runs[i + m - 1].lines;
                }
                nruns -= m - 1;
        } else
                nruns = 0;
        return 0;
}

/* merge all the runs to outfd */
int
mergeall(outfd, outname)
int outfd;
char *outname;
{
        register int i;
        unsigned avail;
        int k, m, w, best, merges, left;
        long sum, bestsum;
        char *p;

        bsize = (maxlen + 1 + 255) & ~255;
        if (bsize < 1024)
                bsize = 1024;
        p = abase;
        avail = asize;
        if (uflag) {
                prevbuf = p;
                p += maxlen + 1;
                avail -= maxlen + 1;
        }
        k = avail / bsize;
        if (k > MAXFAN)
                k = MAXFAN;
        if (k < 2) {
                fprintf(stderr,
                        "sort: lines too long to merge; use a larger -m\n");
                fail(EX_MEM);
        }
        for (i = 0; i < k; i++)
                rd[i].buf = p + i * bsize;

        if (vflag) {
                merges = 1;
                for (left = nruns; left > k; left -= m - 1, merges++)
                        m = left - k + 1 < k ? left - k + 1 : k;
                fprintf(stderr, "sort: %d runs, fan-in %d, %d merge%s\n",
                        nruns, k, merges, merges == 1 ? "" : "s");
        }

        while (nruns > k) {
                m = nruns - k + 1 < k ? nruns - k + 1 : k;
                best = 0;
                bestsum = -1;
                for (w = 0; w + m <= nruns; w++) {
                        sum = 0;
                        for (i = 0; i < m; i++)
                                sum += runs[w + i].size;
                        if (bestsum < 0 || sum < bestsum) {
                                bestsum = sum;
                                best = w;
                        }
                }
                merge(best, m, -1, (char *)NULL);
        }
        merge(0, nruns, outfd, outname);
        return 0;
}

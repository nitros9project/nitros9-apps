/*
 * sort - sort lines of text, for OS-9/6809.
 *
 *      sort [-rfnubv] [-t c] [-k f1[.c1][,f2[.c2]]]... [-o out]
 *           [-T dir] [-m size[k]] [file...]
 *
 * Any amount of input: what does not fit in memory is sorted in
 * memory-sized runs written to temporary files, which are then merged.
 * The sort is stable.  See README.md.
 */

#include "sort.h"

int rflag, fflag, nflag, bflag, uflag, vflag;
int tchar = -1;
struct key keys[MAXKEYS];
int nkeys;
char *outname;
char *tdir;
int aborted;

char *abase, *atop;
unsigned asize;
unsigned maxlen;
long tlines, tbytes;

extern int insorted;
extern char *textend();

#define DEFMEM  ((unsigned)40960) /* largest arena tried */
#define MINMEM  1024

static int
usage()
{
        fprintf(stderr,
"usage: sort [-rfnubv] [-t c] [-k f1[.c1][,f2[.c2]]] [-o out] [-T dir]\n");
        fprintf(stderr,
"            [-m size[k]] [file...]\n");
        exit(EX_USAGE);
        return 0;
}

/* read a decimal number at *pp, advancing *pp past it */
static int
number(pp)
char **pp;
{
        register char *p;
        register int v;

        p = *pp;
        if (*p < '0' || *p > '9')
                usage();
        v = 0;
        while (*p >= '0' && *p <= '9')
                v = v * 10 + *p++ - '0';
        *pp = p;
        return v;
}

/* -k f1[.c1][,f2[.c2]] */
static int
keyarg(s)
char *s;
{
        register struct key *kp;

        if (nkeys >= MAXKEYS) {
                fprintf(stderr, "sort: at most %d keys\n", MAXKEYS);
                exit(EX_USAGE);
        }
        kp = &keys[nkeys++];
        kp->c1 = 1;
        kp->f2 = kp->c2 = 0;
        kp->f1 = number(&s);
        if (*s == '.') {
                s++;
                kp->c1 = number(&s);
        }
        if (*s == ',') {
                s++;
                kp->f2 = number(&s);
                if (*s == '.') {
                        s++;
                        kp->c2 = number(&s);
                }
        }
        if (*s != '\0' || kp->f1 < 1 || kp->c1 < 1 ||
            (kp->f2 != 0 && kp->f2 < kp->f1))
                usage();
        return 0;
}

/* -m size[k] */
static unsigned
memarg(s)
char *s;
{
        long v;

        if (*s < '0' || *s > '9')
                usage();
        v = 0;
        while (*s >= '0' && *s <= '9' && v < 0x10000L)
                v = v * 10 + *s++ - '0';
        if (*s == 'k' || *s == 'K') {
                v *= 1024;
                s++;
        }
        if (*s != '\0')
                usage();
        if (v < MINMEM)
                v = MINMEM;
        if (v > 40960L)
                v = 40960L;
        return (unsigned)v;
}

/* get the largest arena that will fit, up to want bytes */
static int
getarena(want, exact)
unsigned want;
int exact;
{
        register unsigned size;
        char *p;

        for (size = want; size >= MINMEM; size -= 1024) {
                p = sbrk(size);
                if (p != (char *)-1) {
                        abase = p;
                        asize = size;
                        atop = p + size;
                        return 0;
                }
                if (exact)
                        break;
        }
        fprintf(stderr, "sort: not enough memory for a %u byte arena\n",
                want);
        exit(EX_MEM);
        return 0;
}

/* sort the lines in the arena; returns the sorted pointers */
static struct rec **
sortarena(n)
unsigned n;
{
        register struct rec **p, *r;
        register unsigned i;

        p = (struct rec **)textend();
        r = recbase();
        for (i = 0; i < n; i++)
                p[i] = &r[n - 1 - i];
        return msort(p, p + n, n);
}

static int
openout()
{
        int fd;

        if (outname == NULL)
                return 1;
        if ((fd = creat(outname, 3)) < 0) {
                fprintf(stderr, "sort: can't create %s (error %d)\n",
                        outname, errno);
                fail(ERRCODE);
        }
        return fd;
}

main(argc, argv)
int argc;
char **argv;
{
        register char *a;
        unsigned want;
        int exact, more, i, narena, id, fd;
        unsigned n;
        struct rec **sorted;
        long w;
        static char *stdinlist[] = { "-" };

        want = DEFMEM;
        exact = 0;
        for (i = 1; i < argc; i++) {
                a = argv[i];
                if (a[0] != '-' || a[1] == '\0')
                        break;
                if (a[1] == '-' && a[2] == '\0') {
                        i++;
                        break;
                }
                for (a++; *a; a++) {
                        switch (*a) {
                        case 'r': rflag = 1; continue;
                        case 'f': fflag = 1; continue;
                        case 'n': nflag = 1; continue;
                        case 'b': bflag = 1; continue;
                        case 'u': uflag = 1; continue;
                        case 'v': vflag = 1; continue;
                        case 't': case 'k': case 'o': case 'T': case 'm':
                                break;
                        default:
                                usage();
                        }
                        /* an option with a value: the rest of this
                           argument, or the next one */
                        {
                                char opt, *val;

                                opt = *a;
                                val = a + 1;
                                if (*val == '\0') {
                                        if (++i >= argc)
                                                usage();
                                        val = argv[i];
                                }
                                switch (opt) {
                                case 't':
                                        tchar = val[0] & 0xff;
                                        break;
                                case 'k':
                                        keyarg(val);
                                        break;
                                case 'o':
                                        outname = val;
                                        break;
                                case 'T':
                                        tdir = val;
                                        break;
                                case 'm':
                                        want = memarg(val);
                                        exact = 1;
                                        break;
                                }
                        }
                        break;
                }
        }

        getarena(want, exact);
        initcmp();
        initruns();
        if (i < argc)
                inopen(argc - i, argv + i);
        else
                inopen(1, stdinlist);
        if (vflag)
                fprintf(stderr, "sort: %u byte arena\n", asize);

        narena = 0;
        do {
                more = readarena();
                n = nrecs();
                if (more && n == 0) {
                        fprintf(stderr,
                        "sort: line %ld too long for a %u byte arena\n",
                                tlines + 1, asize);
                        fail(EX_MEM);
                }
                narena++;
                if (n == 0)
                        break;
                sorted = sortarena(n);
                if (vflag)
                        fprintf(stderr,
                        "sort: arena %d: %u lines, %ld bytes read, %s\n",
                                narena, n, tbytes,
                                insorted ? "already in order" : "sorted");
                if (!more && nruns == 0) {
                        /* everything fitted: straight to the output */
                        fd = openout();
                        wopen(fd, outname ? outname : "standard output");
                        w = writerecs(sorted, n);
                        wclose(w);
                        if (fd > 2)
                                close(fd);
                        if (vflag)
                                fprintf(stderr,
                                        "sort: written to the output\n");
                        break;
                }
                fd = newrun(&id);
                wopen(fd, "temporary file");
                w = writerecs(sorted, n);
                wclose(w);
                if (vflag)
                        fprintf(stderr, "sort: written as run %d\n", id);
                resetarena();
        } while (more);

        if (nruns == 0 && tlines == 0 && outname != NULL) {
                /* no input: an empty output file, as on Unix */
                fd = openout();
                close(fd);
        }
        if (nruns > 0) {
                fd = openout();
                mergeall(fd, outname ? outname : "standard output");
                if (fd > 2)
                        close(fd);
        }
        if (vflag)
                fprintf(stderr, "sort: %ld lines, %ld bytes\n",
                        tlines, tbytes);
        cleanup();
        exit(EX_OK);
}

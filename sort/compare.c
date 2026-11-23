/*
 * compare.c - finding keys and comparing lines.
 *
 * The comparison is the inner loop of every phase, so it avoids library
 * calls: case folding is a table lookup and numbers are compared as
 * digit strings, with no conversion and no floating point.
 */

#include "sort.h"

int fold[256];          /* byte value, folded to upper case with -f */

#define isblank(c) ((c) == ' ' || (c) == '\t')
#define isdig(c) ((c) >= '0' && (c) <= '9')

int
initcmp()
{
        register int c;

        for (c = 0; c < 256; c++)
                fold[c] = (fflag && c >= 'a' && c <= 'z') ? c - 'a' + 'A' : c;
        return 0;
}

/* offset of the start of field n (from 1) in t; without -t a field is
   its leading blanks and the non-blanks that follow them */
static unsigned
fieldpos(t, l, n)
register char *t;
unsigned l;
int n;
{
        register unsigned i;

        i = 0;
        if (tchar >= 0) {
                while (--n > 0) {
                        while (i < l && (t[i] & 0xff) != tchar)
                                i++;
                        if (i >= l)
                                return l;
                        i++;
                }
                return i;
        }
        while (--n > 0) {
                while (i < l && isblank(t[i]))
                        i++;
                while (i < l && !isblank(t[i]))
                        i++;
        }
        return i;
}

/* offset just past the field that starts at i */
static unsigned
fieldend(t, l, i)
register char *t;
unsigned l;
register unsigned i;
{
        if (tchar >= 0) {
                while (i < l && (t[i] & 0xff) != tchar)
                        i++;
                return i;
        }
        while (i < l && isblank(t[i]))
                i++;
        while (i < l && !isblank(t[i]))
                i++;
        return i;
}

/* find the key kp (or the whole line if kp is NULL) in line t */
int
keyfind(t, l, kp, ks, kl)
char *t;
unsigned l;
register struct key *kp;
char **ks;
unsigned *kl;
{
        register unsigned s, e;

        if (kp == NULL) {
                s = 0;
                if (bflag)
                        while (s < l && isblank(t[s]))
                                s++;
                *ks = t + s;
                *kl = l - s;
                return 0;
        }
        s = fieldpos(t, l, kp->f1);
        if (bflag)
                while (s < l && isblank(t[s]))
                        s++;
        if (kp->c1 > 1)
                s += kp->c1 - 1;
        if (s > l)
                s = l;
        if (kp->f2 == 0)
                e = l;
        else {
                e = fieldpos(t, l, kp->f2);
                if (kp->c2 == 0)
                        e = fieldend(t, l, e);
                else {
                        if (bflag)
                                while (e < l && isblank(t[e]))
                                        e++;
                        e += kp->c2;
                        if (e > l)
                                e = l;
                }
        }
        if (e < s)
                e = s;
        *ks = t + s;
        *kl = e - s;
        return 0;
}

/* compare two strings, folding case with -f */
static int
textcmp(a, al, b, bl)
register char *a, *b;
unsigned al, bl;
{
        register unsigned n;
        int c;

        n = al < bl ? al : bl;
        if (fflag) {
                while (n--) {
                        c = fold[*a++ & 0xff] - fold[*b++ & 0xff];
                        if (c)
                                return c;
                }
        } else {
                while (n--) {
                        c = (*a++ & 0xff) - (*b++ & 0xff);
                        if (c)
                                return c;
                }
        }
        if (al < bl)
                return -1;
        return al > bl;
}

/* split a number into its integer and fraction digits, without leading
   or trailing zeros; returns its sign, 0 for zero or no number */
static int
numparse(p, l, ip, il, fp, fl)
register char *p;
unsigned l;
char **ip, **fp;
unsigned *il, *fl;
{
        register unsigned i;
        unsigned s, e;
        int neg;

        i = 0;
        while (i < l && isblank(p[i]))
                i++;
        neg = 0;
        if (i < l && p[i] == '-') {
                neg = 1;
                i++;
        }
        while (i < l && p[i] == '0')
                i++;
        s = i;
        while (i < l && isdig(p[i]))
                i++;
        *ip = p + s;
        *il = i - s;
        *fp = p + i;
        *fl = 0;
        if (i < l && p[i] == '.') {
                s = ++i;
                while (i < l && isdig(p[i]))
                        i++;
                e = i;
                while (e > s && p[e - 1] == '0')
                        e--;
                *fp = p + s;
                *fl = e - s;
        }
        if (*il == 0 && *fl == 0)
                return 0;
        return neg ? -1 : 1;
}

/* compare two numbers of any length as text */
static int
numcmp(a, al, b, bl)
char *a, *b;
unsigned al, bl;
{
        char *ai, *af, *bi, *bf;
        unsigned ail, afl, bil, bfl, i, n;
        int sa, sb, r, ca, cb;

        sa = numparse(a, al, &ai, &ail, &af, &afl);
        sb = numparse(b, bl, &bi, &bil, &bf, &bfl);
        if (sa != sb)
                return sa < sb ? -1 : 1;
        if (sa == 0)
                return 0;
        r = 0;
        if (ail != bil)
                r = ail < bil ? -1 : 1;
        else {
                for (i = 0; i < ail; i++)
                        if (ai[i] != bi[i]) {
                                r = ai[i] < bi[i] ? -1 : 1;
                                break;
                        }
                if (r == 0) {
                        n = afl > bfl ? afl : bfl;
                        for (i = 0; i < n; i++) {
                                ca = i < afl ? af[i] : '0';
                                cb = i < bfl ? bf[i] : '0';
                                if (ca != cb) {
                                        r = ca < cb ? -1 : 1;
                                        break;
                                }
                        }
                }
        }
        return sa < 0 ? -r : r;
}

static int
fieldcmp(a, al, b, bl)
char *a, *b;
unsigned al, bl;
{
        if (nflag)
                return numcmp(a, al, b, bl);
        return textcmp(a, al, b, bl);
}

/* fill in r's first key */
int
setkey(r)
register struct rec *r;
{
        keyfind(r->t, r->l, nkeys ? &keys[0] : (struct key *)NULL,
                &r->k, &r->kl);
        return 0;
}

/* compare two lines by their keys; equal lines compare 0, so the sort
   keeps them in input order */
int
cmprec(a, b)
register struct rec *a, *b;
{
        register int r, i;
        char *ak, *bk;
        unsigned akl, bkl;

        r = fieldcmp(a->k, a->kl, b->k, b->kl);
        for (i = 1; r == 0 && i < nkeys; i++) {
                keyfind(a->t, a->l, &keys[i], &ak, &akl);
                keyfind(b->t, b->l, &keys[i], &bk, &bkl);
                r = fieldcmp(ak, akl, bk, bkl);
        }
        return rflag ? -r : r;
}

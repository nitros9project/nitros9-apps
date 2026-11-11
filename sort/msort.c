/*
 * msort.c - sort an arena's line records.
 *
 * A stable bottom-up merge sort of record pointers, never moving the
 * text: about n log2 n comparisons whatever the input order, where a
 * simple quicksort falls to n squared on input that is already sorted
 * or reversed.  Slices of 8 are insertion-sorted first, and input that
 * is already in order is noticed in n - 1 comparisons and left alone.
 */

#include "sort.h"

#define SLICE 8

int insorted;           /* set when the input was already in order */

/* sort the n pointers in p, using q as scratch; returns p or q, which
   ever holds the result */
struct rec **
msort(p, q, n)
struct rec **p, **q;
unsigned n;
{
        register struct rec **s, **d;
        register unsigned a, b;
        unsigned i, j, w, lo, mid, hi, k;
        struct rec **t, *x;

        insorted = 0;
        for (i = 1; i < n; i++)
                if (cmprec(p[i - 1], p[i]) > 0)
                        break;
        if (i >= n) {
                insorted = 1;
                return p;
        }

        for (lo = 0; lo < n; lo += SLICE) {
                hi = lo + SLICE < n ? lo + SLICE : n;
                for (i = lo + 1; i < hi; i++) {
                        x = p[i];
                        for (j = i; j > lo && cmprec(p[j - 1], x) > 0; j--)
                                p[j] = p[j - 1];
                        p[j] = x;
                }
        }

        s = p;
        d = q;
        for (w = SLICE; w < n; w += w) {
                for (lo = 0; lo < n; lo += w + w) {
                        mid = lo + w < n ? lo + w : n;
                        hi = mid + w < n ? mid + w : n;
                        a = lo;
                        b = mid;
                        k = lo;
                        while (a < mid && b < hi)
                                if (cmprec(s[b], s[a]) < 0)
                                        d[k++] = s[b++];
                                else
                                        d[k++] = s[a++];
                        while (a < mid)
                                d[k++] = s[a++];
                        while (b < hi)
                                d[k++] = s[b++];
                }
                t = s;
                s = d;
                d = t;
        }
        return s;
}

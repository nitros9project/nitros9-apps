extern unsigned height;
extern int start, magnification;
extern int rows[192];
void maprows(int n)
{
    int i, row;
    for (i = 0; i < height; ++i) {
        row = (long)i * n / height - start * 3 * magnification;
        if (row >= 0 && row < 192)
            rows[row] = i;
    }
}

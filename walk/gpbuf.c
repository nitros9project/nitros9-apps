/* Get/put buffer commands, using c3's register-first argument ABI. */
static putword(p, n)
char *p;
int n;
{
    p[0] = n >> 8;
    p[1] = n;
}

KilBuf(path, group, buffer)
int path, group, buffer;
{
    char cmd[4];
    cmd[0] = 27; cmd[1] = 0x2a;
    cmd[2] = group; cmd[3] = buffer;
    return write(path, cmd, 4);
}

GPLoad(path, group, buffer, type, width, height, size)
int path, group, buffer, type, width, height, size;
{
    char cmd[11];
    cmd[0] = 27; cmd[1] = 0x2b;
    cmd[2] = group; cmd[3] = buffer; cmd[4] = type;
    putword(cmd+5, width); putword(cmd+7, height); putword(cmd+9, size);
    return write(path, cmd, 11);
}

PutBlk(path, group, buffer, x, y)
int path, group, buffer, x, y;
{
    char cmd[8];
    cmd[0] = 27; cmd[1] = 0x2d;
    cmd[2] = group; cmd[3] = buffer;
    putword(cmd+4, x); putword(cmd+6, y);
    return write(path, cmd, 8);
}

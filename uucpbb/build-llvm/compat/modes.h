/* Legacy OS-9 permission bits. These are not POSIX mode_t values. */
#ifndef UUCPBB_MODES_H
#define UUCPBB_MODES_H
#define S_IREAD 0x01
#define S_IWRITE 0x02
#define S_IEXEC 0x04
#define S_IOREAD 0x08
#define S_IOWRITE 0x10
#define S_IOEXEC 0x20
#define S_ISHARE 0x40
#define S_IFDIR 0x80
#endif

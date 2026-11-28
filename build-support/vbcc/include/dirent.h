#ifndef APPS_VBCC_DIRENT_H
#define APPS_VBCC_DIRENT_H
#include "cmoc_os9.h"
typedef CMOC_DIR DIR;
struct dirent {long d_ino;char d_name[30];};
#define opendir cmoc_opendir
#define readdir(d) ((struct dirent *)cmoc_readdir(d))
#define closedir cmoc_closedir
#define rewinddir cmoc_rewinddir
#define seekdir cmoc_seekdir
#define telldir cmoc_telldir
#endif

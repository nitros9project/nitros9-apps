#ifndef APPS_VBCC_UNISTD_H
#define APPS_VBCC_UNISTD_H
#include <os9.h>
#include <stdio.h>
FILE *fdopen(int,const char *);
int fileno(FILE *);
#define STDIN_FILENO 0
#define STDOUT_FILENO 1
#define STDERR_FILENO 2
#define F_OK 0
#define R_OK 4
#define W_OK 2
#define X_OK 1
int access(const char *,int);
int unlink(const char *);
int chdir(const char *);
int getpid(void);
unsigned getuid(void);
int setuid(int);
int dup(int);
void _exit(int);
#endif

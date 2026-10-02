/* OS-9 creates children with F$Fork; POSIX fork/exec is not available. */
#include "llvm.h"
#include <unistd.h>
int os9fork(const char *, int, const void *, int, int, int);
int wait(int *);
static int children[256];
FILE *uucpbb_popen(const char *command, const char *mode)
{
    int pipe, saved, target, pid, length;
    char *copy, *args, *end;
    FILE *stream;
    if (!command || !mode || (mode[0]!='r' && mode[0]!='w') || mode[1]) { errno=EINVAL; return 0; }
    length = strlen(command);
    copy = malloc(length+2);
    if (!copy) return 0;
    memcpy(copy, command, length+1);
    end = copy;
    while (*end && *end!=' ') end++;
    if (*end) { *end++=0; args=end; } else args=end;
    length = strlen(args);
    args[length++]='\r'; args[length]=0;
    pipe = uucpbb_open("/pipe",3);
    if (pipe < 0) { free(copy); return 0; }
    target = mode[0]=='r' ? 1 : 0;
    saved = dup(target);
    if (saved < 0) { close(pipe); free(copy); return 0; }
    close(target);
    if (dup(pipe)!=target) {
        dup(saved); close(saved); close(pipe); free(copy); return 0;
    }
    pid = os9fork(copy,length,args,1,1,0);
    close(target); dup(saved); close(saved); free(copy);
    if (pid < 0) { close(pipe); return 0; }
    stream = fdopen(pipe,mode);
    if (!stream) {
        int status, child;
        close(pipe);
        while ((child=wait(&status))>=0 && child!=pid) { }
        return 0;
    }
    children[pipe]=pid;
    return stream;
}
int uucpbb_pclose(FILE *stream)
{
    int fd=fileno(stream), pid=children[fd], status, child;
    children[fd]=0;
    if (fclose(stream) || !pid) return -1;
    while ((child=wait(&status))>=0) if (child==pid) return status;
    return -1;
}

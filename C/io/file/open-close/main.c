#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

/*
 * Do the same as the touch shell command
 * Open a file, but do no I/O operations
 * if the file does not exists, then create it
 * close the file
 */

int main(int argc, char *argv[]) {
    int fd_1 = open(
        "test.txt",
        O_WRONLY | O_CREAT, // writeonly, create if not present
        S_IRWXU // mode flag: Read, Write and Execute for User
        );
    printf("The file descriptor is %d\n\n", fd_1);
    printf(
        "It must be because\n"
        "%d: is for stdin\n"
        "%d: is for stdout\n"
        "%d: is for stderr\n",
        STDIN_FILENO,
        STDOUT_FILENO,
        STDERR_FILENO
    );
    close(fd_1);
    return 0;
}

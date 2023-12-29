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
    close(fd_1);
    int fd_2 = open(
        "test.txt",
        O_RDONLY | O_CREAT, // writeonly, create if not present
        S_IRWXU // mode flag: Read, Write and Execute for User
        );
    close(fd_2);
    return 0;
}

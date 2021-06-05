#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
// for error codes
#include <errno.h>

/*
 * Open a file, but do no I/O operations
 * if the file does not exists, then create it
 * Open the same path, but try to ensure file creation
 * This will result in a error,
 * Instead of a file descriptor (positive int) open returns -1
 * and the errno (the error code of the last syscall)
 * will be set to 17 (EEXIST)
 */

int main(int argc, char *argv[]) {
    int fd_1 = open(
        "test.txt",
        O_WRONLY | O_CREAT, // writeonly, create if not present
        S_IRWXU // mode flag: Read, Write and Execute for User
        );
    int fd_2 = open(
        "test.txt",
        O_WRONLY | O_CREAT | O_EXCL, // same as above and ensure it is created
        S_IRWXU // mode flag: Read, Write and Execute for User
        );
    if (fd_2 == -1) {
        // EEXIST is defined as 17 in the errno.h header file
        // it is set by the kernel after a file exists error
        if (errno == EEXIST) {
            printf("File already exists, errno code: %d\n", errno);
        }
        else {
            printf("unknown error");
        }
    }
    close(fd_1);
    return 0;
}

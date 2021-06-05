#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    printf("Parent process starts\n");
    int rc = fork();
    if (rc == -1) {
       fprintf(stderr, "fork is failed\n") ;
    }
    else if (rc == 0) {
        printf("I am the child process\n");
    }
    else {
        printf("I am the parent process, the pid of my child is %d\n", rc);
    }
    return 0;
}

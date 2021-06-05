#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

/*
 * Fork a process
 * Set the environment in the child process
 * Run exec to replace the process image of the child
 *
 * Parent waits until the child machine state is zombie
 * Then the parent is terminated and a consequence its child too
 *
 * This is basicly the same how UNIX shell start any command
 */

int main(int argc, char *argv[]) {
    printf("Parent process starts\n");
    int rc = fork();
    if (rc == -1) {
       fprintf(stderr, "fork is failed\n") ;
    }
    else if (rc == 0) {
        // we successfuly forked now we set a
        // environment variable before running exec
        putenv("FOO=bar");
        char* wc_args[4];
        wc_args[0] = strdup("bash");
        wc_args[1] = strdup("-c");
        wc_args[2] = strdup("echo $FOO");
        wc_args[3] = NULL;     // end of array
        execvp(wc_args[0], wc_args);
        // exec will overrida the process image of the calling  process
        // which will be replaced by the process image of the new one
        // in this case the wc process
        printf("This will NOT be printed because of exec\n");
    }
    else {
        int rc_wait = wait(NULL);
        printf("I am the parent process, the pid of my child is %d\n", rc);
    }
    return 0;
}

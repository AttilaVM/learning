#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <sys/wait.h>

/*
 * Fork a process
 * Close the stdout (0) file in the child
 * Open a new file wich will be the new 0 (lowest available file descriptor)
 * Set the environment in the child process
 * Run exec to replace the process image of the child
 * The child process will print to the new file since it prints
 * into 0 file descriptor
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
        // then close the stdout
        close(STDOUT_FILENO);
        // and open a file to redirect the stdout of the subprocess
        // it works without passing the new file descriptor of the new file
        // because we closed the stdout which has the lowest file descriptor (0)
        // and newly opened files are associated with the lowest possible file
        // descriptor and printf() by default writes into the 0 file descriptor
        // and echo (bash) or print (python) uses printf
        open("output.txt", O_CREAT | O_WRONLY | O_TRUNC, S_IRWXU);
        char* bash_args[4];
        bash_args[0] = strdup("bash");
        bash_args[1] = strdup("-c");
        bash_args[2] = strdup("echo $FOO");
        bash_args[3] = NULL;     // end of array
        execvp(bash_args[0], bash_args);
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

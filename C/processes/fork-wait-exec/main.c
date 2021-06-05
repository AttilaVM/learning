#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

int main(int argc, char *argv[]) {
    printf("Parent process starts\n");
    int rc = fork();
    if (rc == -1) {
       fprintf(stderr, "fork is failed\n") ;
    }
    else if (rc == 0) {
        sleep(1);
        char* wc_args[3];
        wc_args[0] = strdup("wc");
        wc_args[1] = strdup("main.c");
        wc_args[2] = NULL;     // end of array
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

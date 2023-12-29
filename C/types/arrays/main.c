#include <stdio.h>

int main(int argc, char *argv[]) {
    int arr[5] = {1, 2, 3, 4, 5};
    // these two expressions are the same
    printf(
        "*(arr + 2): %d\n"
        "arr[2]:     %d\n",
        *(arr + 2),
        arr[2]);

    printf(
        "%p\n"
        "%p\n",
        arr,
        &arr[0]
    );

    return 0;
}

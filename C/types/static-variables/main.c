#include <stdio.h>

int int_inc() {
    // this function will always return 1
    int count = 0;
    count++;
    return count;
}

int static_int_inc() {
    // A static variable preserves it value even
    // after it leaves its scope
    // so the function will "remember" the value of the variable
    // this function will return an incremented number after every call
    static int count = 0;
    count++;
    return count;
}

int main(int argc, char *argv[]) {
    printf("%d ", int_inc());
    printf("%d ", int_inc());
    printf("\n");
    printf("%d ", static_int_inc());
    printf("%d ", static_int_inc());
    return 0;
}

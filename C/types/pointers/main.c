#include <stdio.h>

void int_swap(int* p_0, int* p_1) {
    int p_tmp = *p_0;
    *p_0 = *p_1;
    *p_1 = p_tmp;
}

int main(int argc, char *argv[]) {
    int a = 1;
    int b = 2;

    // & referencing operator
    // refers to the address of an object
    // which can be a variable
    int* address_a = &a;
    printf("%p\n", address_a);
    // or even a function
    void* address_main = &main;
    printf("%p\n", address_main);

    // * has two meanings:
    // dereferencing operator
    // derefers an address to stored object
    printf("verbatim 'a':%d, 'a' dereferenced from its address: %d\n", a, *address_a);
    // or if used in the declaration then it means a pointer type

    printf("%d - %d\n", a, b);
    int_swap(&a, &b);
    printf("%d - %d\n", a, b);

    void* p_indeterminate;
    printf("%p", p_indeterminate);
    return 0;
}

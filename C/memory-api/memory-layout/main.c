#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

/*
 *
 * Example output:
 *
 * start of the code:  0x5600fb3c778a
 * start of the heap:  0x5600fbf0e260
 * start of the stack: 0x7ffd1e87fc14
 * end of the stack:   0xd5fe19c47484
*/

int main(int argc, char *argv[]) {
    // the code comes first in the memory address space
    // the pointer to the main function refers to the start of the
    // in the virtual memory address
    void* beg_code = (void*) main;
    // right after it comes the heap
    // it grows downwards
    void* beg_heap = (void*) malloc(1);

    // stack is located at the end of the virtual address space
    // it grows upwards
    int x = 42;
    // for takes the size of threads stack
    size_t stack_size;
    // attribute declaration
    pthread_attr_t atr;
    pthread_attr_getstacksize(&atr, &stack_size);

    void* stack_beg = (void*) &x;
    // it grows upwards, hence the substraction
    void* stack_end = stack_beg - stack_size;

    printf("start of the code:  %p\n", beg_code);
    printf("start of the heap:  %p\n", beg_heap);
    printf("start of the stack: %p\n", stack_beg);
    printf("end of the stack:   %p\n", stack_end);

    return 0;
}

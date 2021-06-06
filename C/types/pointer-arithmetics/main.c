#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>

int sum_v0(size_t len, int const* p_arr) {
    // just add the incremented i to the array pointer
    // in every iteration (p_arr + i)
    // then difference it with `*`
    int sum = 0;
    for (int i = 0; i < len; i++) {
        sum = sum + *(p_arr + i);
    }
    return sum;
}

int sum_v1(size_t len, int const* p_arr) {
    // however it is more concise to increment a pointer itself
    // whic is at the beginnig has the same address
    // as the `arr` pointer.
    int sum = 0;
    for (int const* p = p_arr; p < p_arr+len; p++) {
        sum = sum + *p;
    }
    return sum;
}

void print_reverse(size_t len, int const* p_arr) {
    int const* p = p_arr + (len - 1);
    while (p >= p_arr) {
        printf("%d ", *p);
        p--;
    }
    printf("\n");
}


int main(int argc, char *argv[]) {
    // the length of an array can not be reconstructed from a pointer
    // so we must store and pass it seperatly
    size_t len = 3;
    int arr[3] = {1, 2, 3};

    printf("sum: %d\n", sum_v0(len, arr));
    printf("sum: %d\n", sum_v1(len, arr));

    print_reverse(len, arr);

    // if we substract two pointers we will have their difference
    int* p_arr_beg = arr;
    int* p_arr_end = arr + len;
    ptrdiff_t pointer_diff = p_arr_end - p_arr_beg;
    printf("%p - %p = %ld\n", p_arr_beg, p_arr_end, pointer_diff);

    return 0;

}

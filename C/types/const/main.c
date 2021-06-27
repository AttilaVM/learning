#include <stdlib.h>
#include <stdio.h>

/*
 * https://softwareengineering.stackexchange.com/a/204720/219587
 */

// # Enumerations
//
#define FRUIT_NUM 3
enum Fruits { Apple, Grape, Peach };

// A constant pointer to a constant `char`
// so neither the pointer position nor the value under the pointer should not be changed
char const* const fruit_names[FRUIT_NUM] = {
    [Apple] = "apple",
    [Grape] = "grape",
    [Peach] = "peach"
};

// # `const` in functions
//
// this is bad practice:
// A functions which are not allowed to modify a passed object under the pointer
// should use the `const` qualifier for its parameter see the `my_pow_2()` function
int my_pow_1(int* a) {
    return (*a) * (*a);
}

int my_pow_2(const int* a) {
    return (*a) * (*a);
}



int main(int argc, char *argv[]) {

    const int a = 42;

    // # how it is enforced
    // The code below would not compile
    //a = 12;
    //
    // but result in this error
    // main.c:14:7: error: assignment of read-only variable ‘a’
    //      a = 12;
    //        ^

    // int* a_ptr = &a;
    //
    // main.c:23:12: error: assignment of read-only location ‘*a_ptr’
    //      *a_ptr = 12;
    //             ^

    // this will work but still cannot be changed
    const int* a_ptr_1 = &a;


    // # How to circumvent the const qualifier
    // sometimes
    //
    // however we can change the value of `a` if cast the pointer to type
    // into a non const qualified one
    int* a_ptr_2 = (int*) &a;
    *a_ptr_2 = 12;
    printf("%d\n", a);

    // # Pass to functions
    // this would throw a warning because the function has no const qualifier for the parameter
    // my_pow_1(&a);
    //
    // main.c:45:14: warning: passing argument 1 of ‘my_pow_1’ discards ‘const’ qualifier from po
    // inter target type [-Wdiscarded-qualifiers]
    // int my_pow_1(&a);
    //     ^
// this will work fine
    my_pow_2(&a);

    enum Fruits fruit = Apple;
    printf("%d\n", fruit);

    puts("\nprint all fruits:");
    for (unsigned int i = 0; i < FRUIT_NUM; i++) {
        printf("%s\n", fruit_names[i]);
    }

    // pointer and value mutabilities
    int*             mutable_pointer_to_mutable_int;
    int  const*      mutable_pointer_to_constant_int;
    int* const       constant_pointer_to_mutable_int;
    int* const const constant_pointer_to_constant_int;

    return 0;
}

#include <stdlib.h>
#include <stdio.h>
#include <limits.h>

#define BYTE_TO_BINARY_PATTERN "%c%c%c%c%c%c%c%c"
#define BYTE_TO_BINARY(byte)  \
  (byte & 0x80 ? '1' : '0'), \
  (byte & 0x40 ? '1' : '0'), \
  (byte & 0x20 ? '1' : '0'), \
  (byte & 0x10 ? '1' : '0'), \
  (byte & 0x08 ? '1' : '0'), \
  (byte & 0x04 ? '1' : '0'), \
  (byte & 0x02 ? '1' : '0'), \
  (byte & 0x01 ? '1' : '0')

void print_uint_binary(unsigned int integer) {
    char* byte_ptr = (char*) &integer;

    printf("Representations of %u\n", integer);

    printf("decimal: ");
    for (unsigned int i = 0; i < sizeof(unsigned int); i++) {
        unsigned char byte = *byte_ptr;
        printf("%u ", byte);
        byte_ptr = byte_ptr + 1;
    }
    printf("\n");

    // reset byte pointer
    byte_ptr = (char*) &integer;
    printf("binary: ");
    for (unsigned int i = 0; i < sizeof(unsigned int); i++) {
        char byte = *byte_ptr;
        printf(BYTE_TO_BINARY_PATTERN " ", BYTE_TO_BINARY(byte));
        byte_ptr = byte_ptr + 1;
    }
    printf("\n\n");
}


int main(int argc, char *argv[]) {

    /* Unsigned integers implement a ring $ Z_{N} $ for addition and multiplication
     * the are module class of $ i \mod N; i,N \in Z $
     * So it is closed under these operations
     *
     * multiplication is distributive for addition
     * b(a + a) = ba + ba
     *
     * and associative
     * (a * b) * c = a * (b * c)
     */
    unsigned int a = 0;
    printf("%u\n", a + UINT_MAX);
    // --> 4294967295
    printf("%d\n\n", a + UINT_MAX + 1);
    // --> 0

    print_uint_binary(0);
    print_uint_binary(1);
    print_uint_binary(2);
    print_uint_binary(4);
    print_uint_binary(255);
    print_uint_binary(256);
    print_uint_binary(UINT_MAX);

    // least and most significant bits
    print_uint_binary(240);


    return 0;
}

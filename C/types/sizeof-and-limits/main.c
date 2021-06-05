#include <stdio.h>
// This header stores system specific min and max values
// for the various C types
// https://pubs.opengroup.org/onlinepubs/009695399/basedefs/limits.h.html
#include <limits.h>

/*
 * Print the byte size of some C types
 *
 * Using the sizeof compile-time operator which runs at
 * compile time and become substituted of the byte size of the
 * given type
 *
 * Print the max and min values of these types by
 * using the predefined values from the limits.h header
 */

int main(int argc, char *argv[]) {
    printf(
        "######### Character types #########\n"
        "char|%zu|%d|%d|signed char\n"
        "unsigned char:|%zu|%d|%d|none\n"
        "######### Integer types #########\n"
        "short:|%zu|%d|%d|short int, signed short, signed short int\n"
        "int:|%zu|%d|%d\n"
        "unsigned int:|%zu|%u|%u\n"
        "long:|%zu|%ld|%ld\n"
        "unsigned long:|%zu|%d|%lu\n",
        sizeof(char),
        CHAR_MIN,
        CHAR_MAX,
        sizeof(unsigned char),
        0,
        UCHAR_MAX,
        sizeof(short),
        SHRT_MAX,
        SHRT_MIN,
        sizeof(int),
        INT_MAX,
        INT_MIN,
        sizeof(unsigned int),
        0,
        UINT_MAX,
        sizeof(long),
        LONG_MIN,
        LONG_MAX,
        sizeof(unsigned long),
        0,
        ULONG_MAX
    );
    return 0;
}

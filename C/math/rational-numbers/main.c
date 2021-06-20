#include <stdio.h>
#include <string.h>

struct Rational {
    long long numerator;
    long long denominator;
};

struct Rational rat_init(
        long long numerator,
        long long denominator
        ) {
    struct Rational r;
    r.numerator = numerator;
    r.denominator = denominator;
    return r;
}

void rat_multiply(
        struct Rational* r_1,
        struct Rational* r_2,
        struct Rational* r_result
        ) {
    r_result->numerator   = r_1->numerator   * r_2->numerator;
    r_result->denominator = r_1->denominator * r_2->denominator;
}

void rat_divide(
        struct Rational* r_1,
        struct Rational* r_2,
        struct Rational* r_result
        ) {
    r_result->numerator   = r_1->numerator   * r_2->denominator;
    r_result->denominator = r_1->denominator * r_2->numerator;
}

void rat_print(struct Rational* r) {
    printf(
        "%lld/%lld\n",
        r->numerator,
        r->denominator
    );
}

int main(int argc, char *argv[]) {
    struct Rational r_1 = rat_init(1, 2);
    struct Rational r_2 = rat_init(4, 2);
    struct Rational r_3;
    struct Rational r_4;

    rat_multiply(&r_1, &r_2, &r_3);
    rat_print(&r_3);

    rat_divide(&r_1, &r_2, &r_4);
    rat_print(&r_4);

    return 0;
}

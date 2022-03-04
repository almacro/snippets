// ex0103.c  Lack of associativity in floating-point computations
#include <stdio.h>
int main()
{
    double sum = 0.0;
    int i;
    for (i = 1; i <= 100000000; i++)
        sum = sum + 1.0/i;
    printf("%.17f\n", sum);

    sum = 0.0;
    for (i = 100000000; i >= 1; i--)
        sum = sum + 1.0/i;
    printf("%.17f\n", sum);
    return 0;
}
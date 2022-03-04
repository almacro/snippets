// ex0101.c  Finite precision of floating point numbers
#include <stdio.h>
int main()
{
    double sum = 0.0;
    int i;
    for(i = 1; i <= 10; i++)
        sum = sum + 0.1;
    printf("%.17f\n", sum);
    return 0;
}
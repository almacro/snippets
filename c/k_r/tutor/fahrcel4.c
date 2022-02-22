#include <stdio.h>
/* 
 * exercise 1-15.
 * Rewrite the temperature conversion program to
 * use a function for conversion
 */
float tocels(float fahr);
int main() 
{
    float fahr, celsius;
    int lower, upper, step;

    lower = 0;      /* lower limit of temperature scale */
    upper = 300;    /* upper limit */
    step = 20;      /* step size */

    printf("%4s\t%6s\n%4s\t%6s\n", "FAHR", "CELS", "----", "----");
    fahr = lower;
    while (fahr <= upper) {
        printf("%3.0f\t%6.1f\n", fahr, tocels(fahr));
        fahr = fahr + step;
    }
}

float tocels(float fahr) {
    return (5.0/9.0) * (fahr - 32.0);
}

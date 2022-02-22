#include <stdio.h>
/* print Celsius-Fahrenheit table
    for cels = 0, 20, ..., 300; floating-point version */
int main() 
{
    float celsius, fahr;
    int lower, upper, step;
    
    lower = 0;      /* lower limit of temperature scale */
    upper = 300;    /* upper limit */
    step = 20;      /* step size */

    printf("%4s\t%6s\n%4s\t%6s\n", "CELS", "FAHR", "----", "----");

    celsius = lower;
    while (celsius <= upper) {
        fahr = 32.0 + celsius * (9.0/ 5.0);
        printf("%3.0f\t%6.1f\n", celsius, fahr);
        celsius = celsius + step;
    }    
}
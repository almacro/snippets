#include <stdio.h>
/* 
 * exercise 1-15.
 * Rewrite the temperature conversion program to
 * use a function for conversion
 */
float tofahr(float cels);
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
        printf("%3.0f\t%6.1f\n", celsius, tofahr(celsius));
        celsius = celsius + step;
    }    
}
float tofahr(float cels) {
    return 32.0 + cels * (9.0/ 5.0);
}

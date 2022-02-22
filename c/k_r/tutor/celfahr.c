#include <stdio.h>
/* 
 * exercise 1-5.
 * Write a program to print the corresponding Celsius to Fahrenheit table
 */
int main() 
{
    int celsius, fahr;
    int lower, upper, step;
    
    lower = 0;      /* lower limit of temperature scale */
    upper = 300;    /* upper limit */
    step = 20;      /* step size */

    celsius = lower;
    while (celsius <= upper) {
        fahr = 32 + ( celsius * 9)/5;
        printf("%d\t%d\n", celsius, fahr);
        celsius = celsius + step;
    }    
}
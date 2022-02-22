#include <stdio.h>
/* 
 * exercise 1-6.
 * verify that the expression: getchar() != EOF 
 * is 0 or 1 
 */
int main() 
{
    int c;
    int n = 0;
    while ((c = getchar()) != EOF)
        if (n < 1) {
            printf("%d\n", getchar() != EOF);
            n = n + 1;
        }
    printf("%d\n", getchar() != EOF);
}
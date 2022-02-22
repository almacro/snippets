#include <stdio.h>
/* 
 * exercise 1-10.
 * Write a program to copy its input to its output, replacing each
 * tab with \t, each backspace with \b, and each backslash with \\.
 */
int main() 
{
    int c;
    while((c = getchar()) != EOF) {
        if(c == '\t')
            printf("\\t");
        else if(c == '\b')
            printf("\\b");
        else if(c == '\\')
            printf("\\\\");
        else
            putchar(c);
    }
}
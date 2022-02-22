#include <stdio.h>
#define BLANK ' '
/*
 * exercise 1-9.
 * copy program input to output, replacing each string of 
 * one or more blanks by a single blank 
 */
int main() 
{
    int c;
    while((c = getchar()) != EOF) {
        if(c == BLANK){
            while((c = getchar()) == BLANK)
                ;
            putchar(BLANK);
        }
        putchar(c);
    }
}
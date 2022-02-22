#include <stdio.h>
#include <stdlib.h>
/*
 * exercise 1-20.
 * Write a program detab that replaces tabs in the input with
 * the proper number of blanks to space to the next tab stop.
 * Assume a fixed set of tab stops, say every N columns.
 * Should N be a variable or a symbolic parameter? 
 */
#define N 8    /* number of columns to tab stop */

int getln(void);
char *ln = NULL;

int main() {
    int len;
    while((len = getln()) > 0) 
        printf("%s", ln);
}

int getln(void) {
    if(ln != NULL)
        free(ln);

    size_t i, n;
    i = n = 0;
    int c;
    while((c = getchar()) != EOF && c != '\n')
    {
        if (i >= n)
        {
            n += 10;
            ln = (char *)realloc((char *)ln, n);
        }
        if(c == '\t') 
        {
            int j;
            for(j = 0; j < N - i % N; ++j) 
                ln[i+j] = ' ';
            i += j;
        }
        else {
            ln[i] = c;
            ++i;
        }
    }
    if(c == '\n') 
    {
        if(i >= n)
            ln = (char *)realloc((char *)ln, i);
        ln[i] = c;
        ++i;
    }
    ln[i] = '\0';
    return i;    
}
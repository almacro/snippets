#include <stdio.h>
#include <stdlib.h>
/*
 * exercise 1-21.
 * Write a program entab that replaces strings of blanks by 
 * the minimum number of tabs and blanks to achieve the same
 * spacing. Use the same tab stops as for detab.
 * When either a tab or a single blank would suffice to reach
 * a tab stop, which should be given preference? 
 */
#define N 8    /* number of columns to tab stop */

int getln(void);
char *ln = NULL;

int main() 
{
    int len;
    while((len = getln()) > 0) 
        printf("%s", ln);
}

int getln(void) 
{
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
        if(c == ' ') 
        {
            size_t j;
            j = 1;
            while((c = getchar()) != EOF && c != '\n' && c == ' ')
                ++j;
            size_t tc, sc;
            tc = j / N;
            sc = j % N;
            if(i + tc + sc >= n) {
                n += 10;
                ln = (char *)realloc((char *)ln, n);
            }
            for(j = 0; j < tc; ++j)
                ln[i++] = '\t';
            for(j = 0; j < sc; ++j)
                ln[i++] = ' ';
        }
        else
        {
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
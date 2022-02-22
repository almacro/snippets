#include <stdio.h>
#include <stdlib.h>
#include <string.h>
/*
 * exercise 1-16.
 * Revise the main routine of the longest-line program so it 
 * will correctly print the length of arbitrarily long input lines
 */
int getln();
char *ln = NULL;

/* print the longest input line */
int main() {
    int len;                  /* current line length */
    int max;                  /* maximum length seen so far */
    char *longest = NULL;     /* longest line saved here */

    max = 0;
    while((len = getln()) > 0) {
        if(len > max) {
            max = len;
            free(longest);
            longest = (char *)malloc(max);
            strcpy(longest,ln);
        }
    }
    if(longest != NULL)     /* there was a line */
        printf("%d | %.30s%s\n", max, longest, (max > 30 ? "..." : ""));
    free(longest);
    return 0;
}

/* getline:  read a line into ln, return length */
int getln() {
    if(ln != NULL)
        free(ln);

    size_t i, n = 0;
    int c;
    for (i = 0; (c = getchar()) != EOF && c != '\n'; ++i) {
        if (i >= n)
        {
            n += 10;
            ln = (char *)realloc((char *)ln, n);
        }
        ln[i] = c;
    }
    if (c == '\n')
    {
        if(i >= n)
            ln = (char *)realloc((char *)ln, i);
        ln[i] = c;
        ++i;
    }
    ln[i] = '\0';
    return i;
}
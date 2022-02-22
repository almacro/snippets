#include <stdio.h>
#include <stdlib.h>
#define MAX 80
/*
 * exercise 1-17.
 * write a program to print all input lines longer than 80 characters
 */
int getln();
char *ln = NULL;

int main() {
    int len;
    int i;
    i = 0;
    while((len = getln()) > 0) {
        if(len > MAX) {
            printf("%3d: %s", i, ln);
        }
        ++i;
    }
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
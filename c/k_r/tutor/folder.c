#include <stdio.h>
#include <stdlib.h>
#define N 72

int getln();
char *ln = NULL;

int main() {
    size_t i, n;
    char c, *w;
    i = n = 0;
    w = NULL;

        int len;
    while((len = getln()) > 0) {
    for(c = 'a'; c < 'i'; ++c) {
        if(i >= n) 
        {
            n += 10;
            w = (char *)realloc((char *)w, n);
        }
        w[i++] = c;
    }
    w[i] = '\0';
    printf("%s\n", w);
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
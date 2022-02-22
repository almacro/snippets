#include <stdio.h>
#include <stdlib.h>
/*
* exercise 1-18.
* Write a program to remove trailing blanks and tabs from each 
* line of input, and to delete entirely blank lines;
*/
int getln();
char *ln = NULL;

int main() {
    int len;
    while((len = getln()) > 0) {
        if(len == 2)
            continue;

        int i = len - 2;
        while(ln[i] == ' ' || ln[i] == '\t')
            --i;
        ln[i+1]='\0';
        printf("%s\n", ln);
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
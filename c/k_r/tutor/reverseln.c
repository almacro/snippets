#include <stdio.h>
#include <stdlib.h>
/*
 * exercise 1-19.
 * Write a function reverse(s) that reverses the character string s.
 * Use it to write a program that reverses its input a line at a time.
 */
char *reverse(char *s);
int getln();
char *ln;

int main() {
    int len;
    while((len = getln()) > 0) 
        printf("%s", reverse(ln));
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

/* reverse:  reverse the character string s */
char *reverse(char *s) {
    int i, j;
    i = 0;
    while(s[i] != '\0')
        ++i;
    j = -1;
    while(++j < --i) {
        char t = s[j];
        s[j] = s[i];
        s[i] = t;
    }
    return s;
}
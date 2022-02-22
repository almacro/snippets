#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int getln();
char *ln = NULL;

int main() {
    int c = getln();
    printf("got %d chars as:\n%s\n", c, ln);
}
int getln() {
    size_t i, n;
    int c;
    n = 0;
    for (i = 0; (c = getchar()) != EOF && c != '\n'; ++i) {
        if(i >= n) {
            n += 10;
            ln = (char *)realloc((char *)ln, n);
            if(ln == NULL) {
                fprintf(stderr, "out of memory with %zu elements", i);
                exit(1);
            }
        }
        ln[i] = c;
    }
    if(c == '\n') {
        if(i >= n)
          ln = (char *)realloc((char *)ln, n + (i - n));
        ln[i] = c;
        ++i;
    }
    ln[i] = '\0';
    return i;
}

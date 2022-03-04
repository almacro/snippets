#include <stdio.h>
#include <stdlib.h>

int main() {
    size_t i, n;
    char c, *w;
    i = n = 0;
    w = NULL;
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
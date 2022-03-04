#include <stdio.h>
#include <stdlib.h>
#include <string.h>
/*
 * exercise 1-22.
 * Write a program to "fold" long input lines into two or more shorter 
 * lines after the last non-blank character that occurs before the 
 * n-th column of input. 
 */

#define N 72  /* column to fold a long string on */

#define IN  1   /* inside a word */
#define OUT 0   /* outside a word */

char *w, *ln;

int main()
{
    int c, wc, state;
    wc = 0;
    state = OUT;

    w = ln = NULL;
    w  = (char *)realloc((char *)w, N);
    ln = (char *)realloc((char *)ln, N);

    while ((c = getchar()) != EOF) {
        if (c == ' ' || c == '\n' || c == '\t') {
            if(c != '\n')
                sprintf(w, "%s%c", w, c);
            if(state == IN)
            {
                if(wc + strlen(ln) < N)
                {
                    sprintf(ln, "%s%s", ln, w);
                }
                else 
                {
                    printf("%s\n", ln);
                    memset(ln, 0, N);
                    strncpy(ln, w, wc);
                    sprintf(ln, "%s ", ln);
                }
            }
            state = OUT;
            wc = 0;
            memset(w, 0, N);
        }
        else if (state == OUT) {
            state = IN;
            if(wc > 0)
            {
                sprintf(ln, "%s%s", ln, w);
            }
            wc = 0;
            memset(w, 0, N);
        }
        if(state == IN)
        {
            if(wc >= N)
            {
                int i;
                for(i = 0; i < wc; ++i) {
                    putchar(w[i]);
                }
                putchar('\\');
                wc = 0;
            }
            w[wc++] = c;
        }
    }
    printf("%s\n", ln);
}
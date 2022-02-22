#include <stdio.h>

#define IN 1  /* inside a word */
#define OUT 0 /* outside a word */
#define MAX_WORD_LENGTH 30

/*
 * exercise 1-13.
 * Write a program to print a histogram of the lengths of words in its
 * input.  It is easy to draw the histogram with the bars horizontal; a
 * vertical orientation is more challenging.
 */
int main()
{
    int count_length[MAX_WORD_LENGTH];
    for (int i = 0; i < MAX_WORD_LENGTH; i++)
    {
        count_length[i] = 0;
    }

    int c, nc, state;
    state = OUT;
    nc = 0;
    while ((c = getchar()) != EOF)
    {
        if (c == ' ' || c == '\n' || c == '\t')
        {
            if(nc > 0) ++count_length[nc];
            state = OUT;
            nc = 0;
        }
        else if (state == OUT)
        {
            state = IN;
        }
        if (state == IN)
            ++nc;
    }

    int i, j;
    for (i = 1; i < MAX_WORD_LENGTH; i++)
    {
        if (count_length[i] > 0)
        {
            printf("%d\t", i);
            for (j = 0; j < count_length[i]; j++) {
                printf("*");
            }
            printf("\n");
        }
    }
}
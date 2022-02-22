#include <stdio.h>

#define ASCII_CHARS 256

/*
 * exercise 1-14.
 * Write a program to print a histogram of the frequencies of
 * different characters in its input. 
 */
int main()
{
    int i, c;
    int count_char[ASCII_CHARS];
    for(i = 0; i < ASCII_CHARS; ++i)
        count_char[i] = 0;

    while ((c = getchar()) != EOF)
        ++count_char[c];

    for (i = 1; i < ASCII_CHARS; i++)
    {
        if (count_char[i] > 0)
        {
            if (i == '\n')
                printf("\\n");
            else if (i == '\t')
                printf("\\t");
            else if (i == ' ')
                printf("SPC");
            else
                printf("%c", i);
            printf("\t");
            
            int j;
            for (j = 0; j < count_char[i]; j++) {
                printf("*");
            }
            printf("\n");
        }
    }
}
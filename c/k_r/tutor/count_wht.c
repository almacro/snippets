#include <stdio.h>
/* 
 * exercise 1-8.
 * count blanks, tabs, and newlines in input 
 */
int main() 
{
    int c, nl, tb, bk;
    nl = tb = bk = 0;
    while((c = getchar()) != EOF)
        if(c == '\n')
            ++nl;
        else if(c == '\t')
            ++tb;
        else if(c == ' ')
            ++bk;
    printf("blank: %d\n", bk);
    printf("tab: %d\n", tb);
    printf("newline: %d\n", nl);
}
#include <stdio.h>
#include <string.h>
/*
 * exercise 1-23.
 * Write a program to remove all comments from a C program.
 * Don't forget to handle quoted strings and character constants
 * properly. C comments don't nest.
 */
#define IN_COMMENT 1
#define OUT_COMMENT 2

#define IN_QUOTE 3
#define OUT_QUOTE 4

#define OPEN_COMMENT "/*"
#define END_COMMENT "*/"
#define LINE_COMMENT "//"

#define DQUOTE '\"'
#define SQUOTE '\''

#define FSLASH '/'
#define BSLASH '\\'
#define STAR '*'
#define NL '\n'

int main() 
{
    int c, state, quote, top;
    char st[2];
    top = 0;
    quote = -1;
    state = OUT_COMMENT;
    while((c = getchar()) != EOF) 
    {
        if(quote != -1)
        {
            if(c == BSLASH) {
                putchar(c);
                putchar(getchar());
            }
            else 
            {
                if(c == quote) quote = -1;
                putchar(c);
            }
        }
        else
        {
            if(c == FSLASH || c == STAR || top > 0)
                st[top++] = c;

            if(top > 1) {
                if(!strncmp(st, LINE_COMMENT, 2)) 
                {
                    while((c = getchar()) != EOF && c != NL);
                    putchar(c);
                }
                else if(!strncmp(st, OPEN_COMMENT, 2))
                    state = IN_COMMENT;
                else if(!strncmp(st, END_COMMENT, 2))
                    state = OUT_COMMENT;                
                else if(state == OUT_COMMENT)
                    printf("%s", st);
                top = 0;
            }
            else if(state == OUT_COMMENT && top == 0)
            {
                if(c == DQUOTE || c == SQUOTE) quote = c;
                putchar(c);
            }           
        }
     }
}
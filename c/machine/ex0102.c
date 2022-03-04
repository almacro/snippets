// ex0102.c  Floating-point errors
#include <stdio.h>
int main()
{
    double x = 1E70;    // 10^70
    double y = 1E5;     // 10^5
    if(x = x + y)
        printf("y must be zero\n");
    else
        printf("y must be nonzero\n");
    return 0;
}
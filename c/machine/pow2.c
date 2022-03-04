// pow2  print powers of 2
#include <stdio.h>
int pow2(int exp);

int main()
{
    int i;
    for(i = 1; i <= 30; i++)
        printf("%d\t%d\n", i, pow2(i));
    return 0;
}

int pow2(int exp)
{
    int r;
    r = 1;
    for(int i=0; i <exp; i++)
    {
        r = r * 2;
    }
    return r;
}
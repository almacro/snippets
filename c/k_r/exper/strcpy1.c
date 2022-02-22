// https://www.tutorialspoint.com/c_standard_library/c_function_strcpy.htm
#include <stdio.h>
#include <string.h>
int main() {
    char src[40];
    char dest[100];
    memset(dest, '\0', sizeof(dest));
    strcpy(src, "This is a demo");
    strcpy(dest, src);
    printf("Final copied string : %s\n", dest);
    return(0);
}
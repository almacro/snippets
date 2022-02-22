#include <stdio.h>
char *reverse(char *s) {
    int i, j;
    i = 0;
    while(s[i] != '\0')
        ++i;
    j = -1;
    while(++j < --i) {
        char t = s[j];
        s[j] = s[i];
        s[i] = t;
    }
    return s;
}
void swap(char *s, int i, int j) {
    char t = s[i];
    s[i] = s[j];
    s[j] = t;
}
void walk(char *s) {
    int i, j;
    i = j = 0;
    while(s[i]!='\0')
        ++i;
        //printf("%c", s[i++]);
    printf("%d\n", i);
   while(i > j)
        swap(s,--i,j++);

    printf("%s\n", s);
}
int main() {
    char p[25] = "breathless ranting";
    //walk(p);
    printf("%s ", p);
    printf("-> %s\n", reverse(p));
}
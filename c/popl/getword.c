#include<stdio.h>
int main() {
  int c;
  size_t i = 0;
  char s[1024];

  while((c = getchar()) != EOF && c != '\n') {
    if(c > 0x20 && c < 0x7F)
      break;
  }

  if(c != EOF && c != '\n') {
    do {
      if(!(c > 0x20 && c < 0x7F))
        break;
      s[i++] = c;
    } while((c = getchar()) != EOF && c != '\n');
  }
  s[i] = 0;
  if(i > 0) {
    printf("%s\n", s);
  } else {
    printf("<no words>\n");
  }

  return 0;
}

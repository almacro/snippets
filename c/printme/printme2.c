char *text [] = {
        "char *text [] = {",
        "0 };",
        "main () {",
        "        char newline = 012, quote = 042, escape = 0134, *p, **pp;",
        "        printf (\"%s%c\", *text, newline);",
        "        for (pp = text; *pp, pp++) {",
        "                printf (\"        %c\", quote);",
        "                for (p = *pp; *p; p++) {",
        "                        if (*p == quote)",
        "                                putchar (escape);",
        "                        putchar (*p);",
        "                }",
        "                printf (\"%c,%c\", quote, newline);",
        "        }",
        "        for (pp = text + 1; *pp; pp++)",
        "                printf (\"%s%c\", *pp, newline);",
        "}",        
0 };
main() {
       char newline = 012, quote = 042, escape = 0134, *p, **pp;
       printf ("%s%c", *text, newline);
       for (pp = text; *pp; pp++) {
               printf ("        %c", quote);
               for (p = *pp; *p; p++) {
                       if (*p == quote)
                               putchar (escape);
                       putchar (*p);
               }
               printf ("%c,%c", quote, newline);
       }
       for (pp = text + 1; *pp; pp++)
               printf ("%s%c", *pp, newline);
}

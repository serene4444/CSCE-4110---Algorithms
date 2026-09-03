// print only valid dates in the form mm/dd/yyyy or mm/dd/yy
#include <stdio.h>
#include <string.h>
#include <regex.h>

int main() {
    regex_t re;
    FILE *fp;
    char line[256];
    regmatch_t match;

    regcomp(&re, "^[0-9]{2}/[0-9]{2}/([0-9]{4}|[0-9]{2})$", REG_EXTENDED);
    fp = fopen("practice.txt", "r");

    while (fgets(line, sizeof(line), fp) != NULL) {
        line[strcspn(line, "\r\n")] = '\0';
        if (regexec(&re, line, 1, &match, 0) == 0) {
            printf("%.*s\n", match.rm_eo - match.rm_so, line + match.rm_so);
        }
    }

    fclose(fp);
    regfree(&re);
    return 0;
}

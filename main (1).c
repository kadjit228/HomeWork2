#include <stdio.h>
char* input_mass() {
    char b[100000];
    int i = 0;
    do {
        char ch = fgetc(stdin);
        b[i++] = ch;
    } while(b[i - 1] != '\n');
    b[i] = '\0';
    char* p = b;
    return p;
}

int check(char s) {
    if (s == 'a' || s == 'e' || s == 'o' || s == 'i' || s == 'u' || s == 'y' || s == 'A' || s == 'E' || s == 'O' || s == 'I' || s == 'U' || s == 'Y') {
        return 1;
    }
    
    return 0;
}

int main() {
    char* str = input_mass();
    int j = 0;
    while(str[j] != '\0') {
        if (check(str[j]) == 1) {
            printf("%d", str[j]);
        } else {
            printf("%c", str[j]);
        }
        j++;
    }
    return 0;
}
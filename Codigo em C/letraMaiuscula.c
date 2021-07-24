#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

// procedimento que converte uma string para maiúsculo
void maiusculo(char s1[], char s2[]){
    int i = 0;
    while(s1[i] != '\0'){
        s2[i] = toupper(s1[i]);
        i++;
    }
    s2[i] = '\0'; 
}

// procedimento que converte uma string para minúsculo
void minusculo(char s1[], char s2[]){
    int i = 0;
    while(s1[i] != '\0'){
        s2[i] = tolower(s1[i]);
        i++;
    }
    s2[i] = '\0'; 
}

int main() {
    char str1[] = "Ola. Bom dia.";
    char str2[500];

    printf("String original: %s\n", str1);

    maiusculo(str1, str2);
    printf("String maiuscula: %s\n", str2);

    minusculo(str1, str2);
    printf("String minuscula: %s\n", str2);

    return 0;
}
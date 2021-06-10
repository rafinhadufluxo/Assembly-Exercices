#include <stdio.h>

int main() {
    int n, aux, primo = 1;

    printf("Digite um numero inteiro: ");
    scanf("%d", &n);
    
    for (aux = 2; aux <= n/2; aux++)
        if ((n % aux) == 0)
            primo = 0;
    
    
    // printf("%d\n", primo);


    if (primo == 1)
        printf("Numero primo\n");
    else
        printf("Numero composto\n");


    return 0;
}
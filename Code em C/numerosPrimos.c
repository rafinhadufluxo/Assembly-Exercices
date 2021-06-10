#include <stdio.h>

int main() {
    int n, aux,resul, primo = 1;

    // printf("Digite um numero inteiro: ");
    // scanf("%d", &n);
    n = 7;
    
    resul = n /2;

    for (aux = 2; aux <= resul; aux++)
        if ((n % aux) == 0)
            primo = 0;
    
    
    // printf("%d\n", primo);


    if (primo == 1)
        printf("Numero primo\n");
    else
        printf("Numero composto\n");


    return 0;
}
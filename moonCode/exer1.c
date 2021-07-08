/**
 * Exercício 1 -  somatorio_10_100: Fazer um programa em linguagem assembly do RISC-V que, através de 
 * um laço, realiza a soma de todos os valores impares entre 10 e 100.
*/


#include<stdio.h>

int main(){
    int impar=0;

    for (int i = 10; i < 100; i++){
        if(i % 2 == 1)
            impar += i;
            // printf("%d\n", i);
        
    }

    printf("NUMERO DE IMPARES %d \n", impar);
    
}
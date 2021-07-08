/**
  Exercício 2 -  conta_par_impar: Fazer um programa em linguagem assembly do RISC-V percorre os 
  elementos de um vetor_A presente na memória e contabiliza a quantidade total de valores 
  pares (em a0) e impares (em a1). Considere que o vetor_A+ possui 12 elementos.
*/

#include <stdio.h>
#include <stdlib.h>

//PAR = 24
//IMPAR = 31

void main(){
    int vetor[12] = {1,3,3,3,5,6,7,8,9,10};
     
    int par=0, impar=0;

    for(int i=0; i<12;i++){
        if(vetor[i] % 2 == 0){
            par += 1;

        }else{
            impar +=1;
        }

    }

    printf("PAR %d\n", par);
    printf("IMPAR %d\n", impar);

}

#Exercício 2 - Leia dois inteiros do teclado e escreva o resultado da sua soma na console. Termine o programa com a chamada do sistema.

li a7, 5 #le o inteiro
ecall

add t0, a0, zero #salva o inteiro lido no temporario 

li a7, 5
ecall

add a0, a0, t0 #soma em t0 com o novo inteiro lido

li a7, 1
ecall

li a7, 10
ecall

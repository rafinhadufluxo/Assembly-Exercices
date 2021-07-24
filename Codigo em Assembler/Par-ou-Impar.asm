#Exercício 4 - Ler um inteiro do teclado e determinar se é um número par ou ímpar.
#Imprimir na tela "Eh par" ou "Eh impar" em resposta. 

.data
	ehpar: 	 .string "Eh par"
	ehimpar: .string "Eh impar"

.text

main:
	li a7, 5  # recebe o número
	ecall



	addi t0, t0, 2 # prepara o 2 para a divisão com resto

	rem t2, a0, t0 #testa se o número é divisível por 2 (par ou ímpar)

	beqz t2, FIM #se o resto é 0, vai pra FIM, senão printa que é ímpar
	la a0, ehimpar
	li a7, 4 
	ecall

	li a7, 10 
	ecall

FIM:
	la a0, ehpar #printa q é par
	li a7, 4 # a7  4 
	ecall

	li a7, 10 
	ecall

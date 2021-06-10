
.data
	ehPrimo: .string "Eh primo parceiro"
	naoPrimo: .string "Nao e primo"

.text
main:
	li a7, 5 #chamada do sistema para ler um inteiro n
	ecall
	
	addi t0, t0, 2 # prepara o 2 para a divisão com resto

	rem t2, a0, t0 #testa se o número é divisível por 2 

	
	beq t0, t2, loop
	addi t0, t0, 1
	

	

loop:
	rem t3 ,a0, t0

	beqz t3, FIM
	la a0, ehPrimo
	li a7, 4 
	ecall  
	
	li a7, 10 
	ecall

FIM:
	la a0, naoPrimo #printa q é não primo
	li a7, 4 # a7  4 
	ecall

	li a7, 10 
	ecall

 #  resul = n /2; t2
    
  #  for (aux = 2; aux <= resul; aux++)
   #     if ((n % aux) == 0)
   #         primo = 0;
    
    
    #// printf("%d\n", primo);


    #if (primo == 1)
     #   printf("Numero primo\n");
    #else
     #   printf("Numero composto\n");

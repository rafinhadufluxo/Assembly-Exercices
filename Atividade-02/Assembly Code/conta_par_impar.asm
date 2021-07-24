#  conta_par_impar: Fazer um programa em linguagem assembly do RISC-V percorre os elementos de um vetor_A presente na memória e 
# contabiliza a quantidade total de valores pares (em a0) e impares (em a1). Considere que o vetor_A+ possui 12 elementos.

#Por favor, verifique o resultado no registrador a0 e a1 os resultado 

.data
	
	vetor:	.word 1,1,3,3,5,6,7,8,9,10,11,12 	
.text



main:
	la t1, vetor
	li t2, 2 			# prepara o 2 para a divisão 
	li t3, 12 			# FOR  i < 12 
	#li t4, 0
	li s2, 0
	li a0, 0			#contador par 
	li a1, 0			#contador impar

loop:
	beq s2, t3, ENDFOR		#Se t2 é igual a 12, caso ao contrario desvia e incrementa +1 
	
	slli t6, s2, 2 			#shift logical left immediate
	add t6, t1, t6 
	
	lw t5,0(t6)			#caminhando pelo v
	
	rem t4, t5, t2			#vetor[i] % 2
	bne t4, zero, ELSE 
	addi a0, a0, 1  		#contador par
	j ENDIF  
		
ELSE: 
	addi a1, a1, 1 		       #contador impar
	

ENDIF:
	addi s2, s2, 1 		      #incremento do desvio do loop
	j loop


ENDFOR:

	#acabou aqui

	
	
	
   	
   			
   	




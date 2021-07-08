.data
	par: 	 .asciz " pares e  "
	impar: .asciz " impares "
	quebraLinha: .asciz "\n"
	vetor:	.word 1,1,3,3,5,7,7,8,9,10,11,12 	
.text



main:
	la t1, vetor
	li t2, 2 			# prepara o 2 para a divisão 
	li t3, 12 			# FOR  i < 12 
	#li t4, 0
	li s2, 0
	li s3, 0			#contador par 
	li s4, 0			#contador impar

loop:
	beq s2, t3, ENDFOR		#FOR 0 até 12
	
	slli t6, s2, 2 
	add t6, t1, t6 
	
	lw t5,0(t6)
	
	rem t4, t5, t2			#vetor[i] % 2
	bne t4, zero, ELSE 
	addi s3, s3, 1  		#contador par
	j ENDIF  
		
ELSE: 
	addi s4, s4, 1 		       #contador impar
	
	#j loop

ENDIF:
	addi s2, s2, 1 #incremento do for
	j loop


ENDFOR:
	
	li a7, 1
	mv a0, s3
	ecall
	
	la a0, par
	li a7, 4
	ecall
	
	
	
	li a7, 1
	mv a0, s4
	ecall
	
	li a7, 4
	la a0, impar
	ecall
	
	
   	
   			
   	




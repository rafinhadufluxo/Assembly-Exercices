
# total de numeros impares são de 2475, mas em hexadecimal é 0x9AB que está no registrador s4.
# Por favor, verifique o print final da resposta no run.

.data
	
	impar: 	 .asciz "\n   Total de impares é  "		
.text

main:
	
	li t1, 10 			
	li t2, 100 			
	li t3, 2			#carregando valor 2 para divisão			
	li s4, 0			#contador impar
	

loop:
	beq t1, t2, FIM
	rem t4, t1,t3
	bne t4, zero , ELSE  		# se o t4 não for igual a 0, pula para else e add o valor no impar

	j ENDIF  
		
ELSE: 
	add s4, s4, t1  		#contador impar (SOMA)

ENDIF:
	addi t1, t1, 1 			#incremento do for
	j loop

FIM:
	
	la a0, impar
	li a7, 4
	ecall
	
	li a7, 1
	mv a0, s4
	ecall

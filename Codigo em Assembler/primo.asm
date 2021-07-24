.data
	ehPrimo: .asciz "Eh primo parceiro"
	naoPrimo: .asciz "Nao e primo"
.text

main:
	#li a7, 5 #chamada do sistema para ler um inteiro n
	addi 	a7, zero, 5  #lê inteiro
	

	ecall
	li t0, 2 # prepara o 2 para a divisão 
	li t1, 1 
	div t2, a0, t0 

loop:
    	beq t0, t2, ENDFOR
    	rem t3, a0, t0
    	bne t3, zero, ENDIF
    	li t1, 0 
    	
ENDIF:
   	addi t0, t0, 1
   	j loop
   	
ENDFOR:
    	beqz t1, ELSE
    	la a0, ehPrimo
    	li a7, 4
    	ecall

    	li a7, 10
   	ecall
    	j END
ELSE:
    	la a0, naoPrimo
    	li a7, 4
   	ecall

    	li a7, 10
   	ecall
END:

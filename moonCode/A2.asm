		.data
vector_A:	.word 	-5, 4, 2, -11, 9
vector_B: 	.word	9, 4, -2, 3, 6
vector_C:	.space  20
vector_length:	.word	5	

		.text
main:
	la	a0, vector_A		# load address of vector_A 
	la	a1, vector_B		# load address of vector_B 
	la	a2, vector_C		# load address of vector_C 
	lw	t0, vector_length	# load value of vector_length
#	lw	t3, vector_A		# load value of first element of vector_A

init:		
	addi 	t1, zero, 0		# init loop control variable # x = 0
	
cond:	bge 	t1, t0, end_loop	# test end of loop
	lw	s0, 0 (a0)		# load value of vector_A[x]
	lw	s1, (a1)		# load value of vector_B[x]
	
if_equal:
	beq	s0, s1, equal		# verify if vector_A[x] ==  vector_B[x]

if_A_greater:
	bgt	s0, s1, A_greater	# verify if vector_A[x] >  vector_B[x]

A_minnor: 
	addi    t2, zero, -1		# when vector_A[x] <  vector_B[x]
	sw	t2, (a2)		# vector_C[x] = -1

update_control:
	addi	a0, a0, 4		# &vector_A = &vector_A + 4
	addi	a1, a1, 4		# &vector_B = &vector_B + 4
	addi	a2, a2, 4		# &vector_A = &vector_C + 4
	addi	t1, t1, 1		# x = x + 1
	j	cond			# jump to label cond

equal:
	sw	zero, (a2)		# vector_C[x] = 0
	j	update_control		# jump to label cond
	
A_greater:
	addi    t2, zero, 1
	sw	t2, (a2)		#vector_C[x] = 1
	j	update_control		# jump to label cond

end_loop:
	nop
	li a7, 93
	ecall 

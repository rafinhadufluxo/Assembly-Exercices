.data 
    fib: 	 .string "O termo de fibonacci vai ser "

.text 
    li a7, 5 #le um inteiro que indica n 
    ecall 
    li a1, 2 #inicia a1 como F(2) e serve de contador do fibonacci
    li t1, 1 #inicia t1 como 1
    li t0, 1 #inicia t1 como 1
    add s0, s0, a0
    jal fibo
    jal fim
    
    fibo: 
        addi sp, sp, -8
        sw t0, 0(sp)
        sw t1, 4(sp)
        blt a1, a0, somafibo # if a0 >= a1 then target
        jal fim

    somafibo:
        lw t0, 0(sp)
        lw t1, 4(sp)
        add t3, t0, zero
        add t0, t0, t1 
        add t1, t3, zero
        addi a1, a1, 1
        addi sp, sp, 8
        jal fibo

    fim:
        la a0, fib 
        li a7, 4
        ecall 
        lw a0, 0(sp)
        li a7, 1
        ecall 
        li a7, 10
        ecall

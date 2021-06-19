.data 
    fib:    .string "O termo de fibonacci vai ser "
.text
    li a7, 5
    ecall 
    li a1, 2
    li a2, 1
    addi sp, sp, -16
    sw a2, 0(sp)
    sw a2, 8(sp)
    jal funcao_rec
    jal fim


    funcao_rec:
    addi sp, sp, -8
    sw ra, 4(sp)
    sw a2, 0(sp)
    ble a0, a1, fr_retorna
    addi a0, a0, -1
    jal funcao_rec

    fr_retorna:
    lw t0, 0(sp)
    lw ra, 4(sp)
    lw t1, 8(sp)
    add t0, t0, t1
    sw t0, 16(sp)
    addi sp, sp, 8
    ret

fim: 
    la a0, fib 
    li a7, 4
    ecall 
    lw a0, 0(sp)
    li a7, 1
    ecall 
    li a7, 10
    ecall

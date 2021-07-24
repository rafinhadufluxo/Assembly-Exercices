.data

entrada: .asciz "isto eh uma string"
mensagem:.asciz "numero de vogais = "
form1: .asciz "\ntexto original = "
form2: .asciz "\ntexto sem vogais = "

.text

main:
      la a0, mensagem
      li a7, 4
      ecall    # imprime explicacao
      jal ra, ContaVogais # calcular resultado
      #mv a0, a7
      li a7, 1
      ecall   # imprime resultado que voltou em a0

      la a0, form1
      li a7, 4
      ecall
      li a0, '"'
      li a7, 11
      ecall
      la a0, entrada
      li a7, 4
      ecall
      li a0, '"'
      li a7, 11
      ecall

      jal ra, EliminaVogais

      la a0, form2
      li a7, 4
      ecall
      li a0, '"'
      li a7, 11
      ecall
      la a0, entrada
      li a7, 4
      ecall
      li a0, '"'
      li a7, 11
      ecall

      li a7, 10
      ecall   # termina programa com código 0 (tudo ok)
      
ContaVogais:

     mv t2, ra  # salva para poder voltar para main
     la t0, entrada # texto a ser analizado
     li t1, 0       # contagem de vogais
     
     loop:
       lbu a0, 0(t0)  # le proxima letra
       beq a0, zero, acabou  # nao pode ser '\0'
       jal ra, EhVogal   # verifica se eh vogal
       add t1, t1, a0  # 1 se vogal (incrementa) ou 0 se nao for (fica igual)
       addi t0, t0, 1 # aponta para proxima letra
       j loop
     
     acabou:
       mv a0, t1  # substitue o '\0' pela contagem como resposta
       mv ra, t2 # restaura
       ret
       
       
EhVogal:

       li t4,'a'
       beq t4,a0, verdade
       li t4, 'e'
       beq t4, a0, verdade
       li t4, 'i'
       beq t4, a0, verdade
       li t4, 'o'
       beq t4, a0, verdade
       li t4, 'u'
       beq t4, a0, verdade
       li a0, 0
       ret
       
verdade:
       li a0, 1
       ret

EliminaVogais:
       mv t2,ra
       la t0, entrada # texto original
       la t1, entrada # texto sem vogais
varre:
       lbu t3,0(t0)  # proxima letra
       beq t3, zero, fimdetexto
       mv a0, t3
       jal ra, EhVogal
       bne a0, zero, pula
       sb t3,0(t1)
       addi t1, t1, 1  # proxima letra
pula:
       addi t0, t0, 1  # proxima letra a copia (ou nao)
       j varre
       
fimdetexto:
       sb t3,0(t1)  # a ultima letra eh \0 e precisa ser copiada tambem
       mv ra,t2
       ret

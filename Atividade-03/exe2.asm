.globl main
	.data
#Mensagens que ser�o exibidas ao usu�rio
msg_opc:	.string "\n Digite uma opcao"
quebra_linha:	.string "\n"
msp_opc_1:	.string "1 - Peencher vetor"
msp_opc_2:	.string "2 - Ordenar vetor"
msp_opc_3:	.string "3 - Imprimir vetor"
msp_opc_4:	.string "4 - Sair"
msg_vet:	.string "Vetor: "
space:		.string " "

msg_qual_valor: .string "Digite o valor a ser inserido no vetor"

msg_erro_listagem: .string "Vetor est� vazio!"
msg_inserido_sucesso: .string "Valor inserido com sucesso!"
msg_sucesso_ord: .string "Vetor ordenado!\n"

	.text
main:
	addi sp, sp, -8 #Aloco 8 bytes inicial para inserir o primeiro elemento
	add s0, zero, sp #carrega endereco inicial do vetor alocado
	add s1, zero, sp #carrega endereco inicial do vetor alocado p/ futuras insercoes
	add s2, zero, sp #carrega endereco inicial do vetor alocado p/ futuras ordenacoes
	add s3, zero, s0 #carrega endereco inicial do vetor alocado p/ futuras remocoes
	add t1, zero, zero #contador do numero de insercoes feitas
	addi t2, zero, 4 #add 4 p/ deslocamento futuro
	addi s10, zero, 1 
	add a4, zero, zero
	addi a6, zero, 1 
	add t0, zero, zero
	add a0, zero, zero 
	j lista_opcoes
##################################################################################################

 #faz chamada para mostrar o menu com as op��es que poder�o ser usadas
lista_opcoes:
	addi t6, zero, 1
	la a0, msg_opc
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	la a0, msp_opc_1
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	la a0, msp_opc_2
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	la a0, msp_opc_3
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	la a0, msp_opc_4
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	li a7, 5 #le valor digitado no teclado e armazena em a0
	ecall
	add t3, zero, a0 #move valor do teclado para t3
	beq t3, t6, insere_elemento
	addi t6, t6, 1		#gambiarra p/ usar so um registrador e verificar se o numero digitado
	beq t3, t6, ordena_elementos	#e igual ao ao que esta no reg, toda vez sendo somado
	addi t6, t6, 1
	beq t3, t6, listar_elementos
	addi t6, t6, 1
	beq t3, t6, end
	
	la a0, quebra_linha
	li a7, 4
	ecall
	j lista_opcoes
############################################################################################################

#fun��o para inserir um elemento na lista
insere_elemento:
	la a0, msg_qual_valor #pede o valor o qual ser� inserido
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	li a7, 5 #le valor digitado no teclado e armazena em a0
	ecall
	beq t1, zero, insere_primeiro #se for o primeiro valor, ele chama uma fun��o especial para inserir, pois ja foi feita a primeira aloca��o no in�cio do programa
	addi sp, sp, -8 #armazena 8 bytes sendo 4 para o inteiro e 4 para o pr�x endere�o
	sw a0, (sp)  #armazena o valor digitado em a0 nos primeiros 4 bytes do sp alocado
	sw zero, 4(sp) #armazena o pr�ximo endere�o como NULL (0)
	sw sp, (s1) #armazena o endere�o do segundo elemento no n� do anterior
	add s1, sp, t2	#carrega o endereco que vai o prox endereco do valor da lista
	addi t1, t1, 1 #incrementa o valor de quantos tem na lista
	addi t0, t0, 1 #incrementa o valor de quantos tem na lista
	la a0, msg_inserido_sucesso #Mensagem para dizer que o valor foi inserido com sucesso
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	j lista_opcoes

#fun��o que faz a inser��o do primeiro valor na lista
insere_primeiro:
	sw a0, (sp) #armazena o valor digitado em a0 nos primeiros 4 bytes do sp alocado inicialmente
	sw zero, 4(sp) #armazena o pr�ximo endere�o como NULL (0)
	addi t1, zero, 1 #incrementa o valor de quantos tem na lista
	addi t0, zero, 1 #incrementa o valor de quantos tem na lista
	add s1, sp, t2 #carrega em s1 o endere�o onde ser� alocado o pr�ximo valor inserido
	la a0, msg_inserido_sucesso #Mensagem para dizer que o valor foi inserido com sucesso
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	j lista_opcoes
########################################################################################################
#func�o que ordena os elementos adicionados baseado no algoritmo selection sort
ordena_elementos:
	add t4, zero, s0 #armazena o endere�o inicial da lista em t4
	j for_ordena

for_ordena: #primeiro for do selection sort
	jal add_inicio_vetor
	lw t5, 4(t4) #carrega o endere�o do pr�ximo valor em t5
	beq t5, zero, fim_ordenacao #caso t5 for zero, ou NULL neste caso, ele termina o for
	jal for_ordena2 #pula para o segundo for

for_ordena2:
	lw a4, (t5) #carrega o valor e o endere�o nos reg a4 e a5
	lw a5, 4(t5)
	beq a5, zero, terminou_segundo_for #caso o end do pr�ximo � zero, ele termina o la�o
	blt a4, s6, swap_menor_valor #verifica se o valor � menor do que o que j� foi setado como menor, caso for ele altera este valor
	lw t5, 4(t5)
	j for_ordena2 #volta a fazer o segundo for
	
add_inicio_vetor: #fun��o para inserir o primeiro valor da lista e o seu endere�o, tambem ja seta o mesmo como o menor valor, depois � feito a busca para ver se possui outro menor
#para fazer o swap
	add a2, zero, t4 #recebe o valor inicial e o seu endere�o em a3
	lw a3, (a2)
	add s6, zero, a3 #s6 e s7 correspondem aos reg que guardam o menor valor e o seu endere�o
	add s7, zero, a2
	ret
	
swap_menor_valor:
	add s6, zero, a4
	add s7, zero, t5
	addi s8, zero, 1 #passa para true que houve um valor menor que o inicial e teve swap
	j for_ordena2

swap_menor_valor_ultimo:
	add s6, zero, a4
	add s7, zero, t5
	addi s8, zero, 1 #passa para true que houve um valor menor que o inicial e teve swap
	beq s10, s8, swap_vetor_ultimo #se o s8 igual a true, ou seja, teve valor menor, faz a troca
	lw t4, 4(t4)
	j for_ordena

swap_vetor_ultimo:
	add s4, zero, a3 #s4 recebe como auxiliar para swap
	sw s6, (a2)
	sw s4, (s7)
	add s8, zero, zero #passa o swap como false
	j for_ordena

terminou_segundo_for:
	blt a4, s6, swap_menor_valor_ultimo #verifica se o ultimo valor ainda pode ocorrer de ser trocado, por ser o menor valor da lista
	beq s10, s8, swap_vetor #se o s8 igual a true, ou seja, teve valor menor, faz a troca
	lw t4, 4(t4)
	j for_ordena #chama o primeiro for para come�ar a percorrer a partir do segundo valor
	
swap_vetor: #faz a troca na lista em si, colocando o valor menor na posi��o respectiva 
	add s4, zero, a3 #s4 recebe como auxiliar para swap
	sw s6, (a2)
	sw s4, (s7)
	add s8, zero, zero #passa o swap como false
	j prox_for_1

prox_for_1:
	lw t4, 4(t4)
	j for_ordena
	
fim_ordenacao: #Quando chega no fim da ordena��o, chama fun��o que limpa os registradores usados, e lista o menu novamente
	jal limpa_regs
	addi t6, zero, 1
	la a0, msg_sucesso_ord
	li a7, 4
	ecall
	j lista_opcoes
	
limpa_regs: #fun��o que limpa todos registradores usados
	add a2, zero, zero
	add a3, zero, zero
	add a4, zero, zero
	add a5, zero, zero
	add s4, zero, zero
	add s6, zero, zero
	add s7, zero, zero
	add s8, zero, zero
	add t4, zero, zero
	add t5, zero, zero
	add s3, zero, s0
	ret
	
#############################################################################################
#come�a funcao para imprimir o vetor
listar_elementos:
	add s3, zero, s0
	beq t1, zero, errodelistagem #caso a lista esteja vazia, retorna para um erro, senao ele continua para imprimir
	la a0, msg_vet
	li a7, 4
	ecall
	j lista
	
lista:	#Faz um loop para impressao dos valores
	lw a0, (s3)
	li a7, 1
	ecall
	lw s3, 4(s3)
	beq s3, zero, fimlistagem
	la a0, space
	li a7, 4
	ecall
	j lista
	
fimlistagem: #quebra linha e volta para o menu ap�s terminar de listar os elementos
	add s3, zero, s0 #retorna s3 para o endereco inicial da lista
	la a0, quebra_linha
	li a7, 4
	ecall
	j lista_opcoes
	
	
errodelistagem: #se a lista estiver vazia, ele da mensagem de erro e retorna para o menu
	la a0, msg_erro_listagem
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	j lista_opcoes
	
########################################################################################
#funcao para finalizar o programa	
end:
	la a0, quebra_linha
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	nop
	ebreak

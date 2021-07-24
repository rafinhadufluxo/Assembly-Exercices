.globl main
	.data
#Mensagens que serão exibidas ao usuário
msg_opc:	.string "Digite uma opcao"
quebra_linha:	.string "\n"
msp_opc_1:	.string "1 - Inserir elemento"
msp_opc_2:	.string "2 - Remover elemento por indice"
msp_opc_3:	.string "3 - Remover elemento por valor"
msp_opc_4:	.string "4 - Listar elementos da lista"
msp_opc_5:	.string "5 - Sair"
msg_vet:	.string "Vetor: "
space:		.string " "
msg_valor_erro: .string "Valor digitado invalido insiva novamente um valor valido"
msg_qual_valor: .string "Digite o valor a ser inserido na lista"
msg_erro_inser: .string "Nao foi possivel inserir o valor na lista"
msg_erro_listagem: .string "Lista está vazia!"
msg_indice_maior: .string "O numero e maior do que o numero de indices inseridos no vetor!"
msg_nao_encontrou: .string "O valor nao consta no vetor!"
msg_digite_valor: .string "Digite o valor o qual deseja remover"
vlr_prim_rem:	.string "Primeiro valor removido com exito!"
vlr_ult_rem:	.string "Ultimo valor removido com exito!"
lst_vazia:	.string "Lista vazia!"
msg_digite_indice: .string "Digite qual índice voce deseja remover"
msg_2_indice: .string "Segundo indice removido com sucesso!"
msg_rm_sucesso: .string "Valor removido com sucesso!"
msg_final: .string "Obrigado por usar o programa :) O numero de itens inseridos foi de "
msg_final_1: .string ". E o número de itens removidos foi de "
msg_inserido_sucesso: .string "Valor inserido com sucesso!"
msg_indice_removido: .string "O indice removido foi o "
msg_numero_removido: .string "O numero removido foi o "

	.text
main:
	addi sp, sp, -8 #Aloco 8 bytes inicial para inserir o primeiro elemento
	add s0, zero, sp #carrega endereço inicial do vetor alocado
	add s1, zero, sp #carrega endereço inicial do vetor alocado p/ futuras insercoes
	add s2, zero, sp #carrega endereço inicial do vetor alocado p/ futuras ordenacoes
	add s3, zero, s0 #carrega endereço inicial do vetor alocado p/ futuras remocoes
	add t1, zero, zero #contador do numero de insercoes feitas
	addi t2, zero, 4 #add 4 p/ deslocamento futuro
	addi s10, zero, 1 #futuramente usado para remover elemento
	add a4, zero, zero
	addi a6, zero, 1 
	add t0, zero, zero #dedicado a guardar o total de inserções feitas para a mensagem final
	add a0, zero, zero #dedicado a guardar o total de remoções feitas para a mensagem final
	j lista_opcoes
##################################################################################################

 #faz chamada para mostrar o menu com as opções que poderão ser usadas
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
	la a0, msp_opc_5
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
	beq t3, t6, remover_por_indice	#e igual ao ao que esta no reg, toda vez sendo somado
	addi t6, t6, 1
	beq t3, t6, remover_por_valor
	addi t6, t6, 1
	beq t3, t6, listar_elementos
	addi t6, t6, 1
	beq t3, t6, end
	la a0, msg_valor_erro #caso o valor nao seja da lista informada, 
	li a7, 4		#ele dá erro e manda inserir novamente um valor válido
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	j lista_opcoes
############################################################################################################

#função para inserir um elemento na lista
insere_elemento:
	la a0, msg_qual_valor #pede o valor o qual será inserido
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	li a7, 5 #le valor digitado no teclado e armazena em a0
	ecall
	beq t1, zero, insere_primeiro #se for o primeiro valor, ele chama uma função especial para inserir, pois ja foi feita a primeira alocação no início do programa
	addi sp, sp, -8 #armazena 8 bytes sendo 4 para o inteiro e 4 para o próx endereço
	sw a0, (sp)  #armazena o valor digitado em a0 nos primeiros 4 bytes do sp alocado
	sw zero, 4(sp) #armazena o próximo endereço como NULL (0)
	sw sp, (s1) #armazena o endereço do segundo elemento no nó do anterior
	add s1, sp, t2	#carrega o endereco que vai o prox endereco do valor da lista
	addi t1, t1, 1 #incrementa o valor de quantos tem na lista
	addi t0, t0, 1 #incrementa o valor de quantos tem na lista
	la a0, msg_inserido_sucesso #Mensagem para dizer que o valor foi inserido com sucesso
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	j ordena_elementos

#função que faz a inserção do primeiro valor na lista
insere_primeiro:
	sw a0, (sp) #armazena o valor digitado em a0 nos primeiros 4 bytes do sp alocado inicialmente
	sw zero, 4(sp) #armazena o próximo endereço como NULL (0)
	addi t1, zero, 1 #incrementa o valor de quantos tem na lista
	addi t0, zero, 1 #incrementa o valor de quantos tem na lista
	add s1, sp, t2 #carrega em s1 o endereço onde será alocado o próximo valor inserido
	la a0, msg_inserido_sucesso #Mensagem para dizer que o valor foi inserido com sucesso
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	j lista_opcoes
########################################################################################################
#funcão que ordena os elementos adicionados baseado no algoritmo selection sort
ordena_elementos:
	add t4, zero, s0 #armazena o endereço inicial da lista em t4
	j for_ordena

for_ordena: #primeiro for do selection sort
	jal add_inicio_vetor
	lw t5, 4(t4) #carrega o endereço do próximo valor em t5
	beq t5, zero, fim_ordenacao #caso t5 for zero, ou NULL neste caso, ele termina o for
	jal for_ordena2 #pula para o segundo for

for_ordena2:
	lw a4, (t5) #carrega o valor e o endereço nos reg a4 e a5
	lw a5, 4(t5)
	beq a5, zero, terminou_segundo_for #caso o end do próximo é zero, ele termina o laço
	blt a4, s6, swap_menor_valor #verifica se o valor é menor do que o que já foi setado como menor, caso for ele altera este valor
	lw t5, 4(t5)
	j for_ordena2 #volta a fazer o segundo for
	
add_inicio_vetor: #função para inserir o primeiro valor da lista e o seu endereço, tambem ja seta o mesmo como o menor valor, depois é feito a busca para ver se possui outro menor
#para fazer o swap
	add a2, zero, t4 #recebe o valor inicial e o seu endereço em a3
	lw a3, (a2)
	add s6, zero, a3 #s6 e s7 correspondem aos reg que guardam o menor valor e o seu endereço
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
	j for_ordena #chama o primeiro for para começar a percorrer a partir do segundo valor
	
swap_vetor: #faz a troca na lista em si, colocando o valor menor na posição respectiva 
	add s4, zero, a3 #s4 recebe como auxiliar para swap
	sw s6, (a2)
	sw s4, (s7)
	add s8, zero, zero #passa o swap como false
	j prox_for_1

prox_for_1:
	lw t4, 4(t4)
	j for_ordena
	
fim_ordenacao: #Quando chega no fim da ordenação, chama função que limpa os registradores usados, e lista o menu novamente
	jal limpa_regs
	j lista_opcoes
	
limpa_regs: #função que limpa todos registradores usados
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
	
##################################################################################################
#função que faz a remoção na lista do valor passado, se existir
remover_por_valor: #solicita o valor que deseja ser removido, caso a lista não esteja vazia
	beq, t1, zero, lista_vazia #se t1 é zero, desvia pro erro de lista vazia
	la a0, msg_digite_valor	#pede valor no teclado
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	li a7, 5 #le valor digitado no teclado e armazena em a0
	ecall
	add s3, zero, s0
	jal for #desvia pro loop
	
lista_vazia: #retorna mensagem dizendo q a lista esta vazia para remover algum elemento
	la a0, lst_vazia
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	jal limpa_reg
	j lista_opcoes
	
for: #loop para percorrer a lista e procurar o elemento a ser removido
	lw s5, (s3) #armazena o valor que esta no end s3 no reg s5
	beq s5, a0, encontrou_valor_remocao #verifica se o valor foi encontrado
	addi s4, s3, 4 #s4 recebe o end do anterior
	lw s3, (s4) #armazena o end do proximo elemento pra verificar novamente
	beq s3, zero, nao_encontrou
	addi s10, s10, 1
	j for
			
encontrou_valor_remocao:
	addi s11, zero, 1
	beq s10, s11, remover_primeiro_elem #desvia para funcao que remove primeiro indice
	lw s6, 4(s3) #se o end do prox é zero, então ele e o ultimo valor
	beq zero, s6, encontrou_valor_remocao_ultimo
	j remocao_valor_meio
	
remocao_valor_meio: #função que "remove" o valor do meio da lista, na verdade, o anterior aponta não mais para o proximo, e sim o que vem depois dele
	sw s6, (s4)
	la a0, msg_rm_sucesso
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	la a0, msg_indice_removido
	li a7, 4
	ecall
	add a0, zero, s10
	li a7, 1
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	jal limpa_reg
	addi t1, t1, -1
	addi a1, a1, 1
	j lista_opcoes
	
encontrou_valor_remocao_ultimo: #caso seja o ultimo valor que será removido, entra nesta função, limpando o ultimo valor, o nó do anterior, e desalocando 8 bytes na pilha
	sw zero, (s3)
	sw zero, (s4)
	addi sp, sp, 8
	add s1, zero, s4
	la a0, vlr_ult_rem
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	addi t1, t1, -1
	addi a1, a1, 1
	jal limpa_reg
	j lista_opcoes
	
remover_primeiro_elem: #atualiza o endereco inicial do vetor pro segundo, teoricamente removendo o primeiro elemento
	lw s9, 4(s0)
	add s0, zero, s9
	add s2, zero, s9
	add s3, zero, s9
	la a0, vlr_prim_rem
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	jal limpa_reg
	addi t1, t1, -1
	addi a1, a1, 1
	j lista_opcoes
	
nao_encontrou: #retorna a mensagem que o valor inserido nao está na lista
	la a0, msg_nao_encontrou
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	jal limpa_reg
	j lista_opcoes

limpa_reg: #função para limpar os registradores usados
	addi s10, zero, 1
	add s6, zero, zero
	add s5, zero, zero
	add s4, zero, zero
	add s3, zero, s0
	add s11, zero, zero
	ret
################################################################################################
#funcao que faz a remocao pelo indice da lista informado pelo usuário	
remover_por_indice:
	la a0, msg_digite_indice
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	li a7, 5 #le valor digitado no teclado e armazena em a0
	ecall
	blt t1, a0, valor_acima #caso o valor digitado pelo usuário seja maior do que o número de índices, acaba ocasionando o erro
	beq a0, s10, remove_prim #caso o indice seja o primeiro, desvia para esta função
	j for1 #senao percorre a lista até chegar no índice passado

for1:	
	lw s5, (s3)
	beq s10, a0, encontrou_valor #se o loop andou até o índice passado pelo usuário, chama a função que encontrou o valor
	addi s4, s3, 4
	lw s3, 4(s3)
	addi s10, s10, 1
	j for1		
	
encontrou_valor:
	lw s3, 4(s3)
	beq s3, zero, rem_ultimo #caso o endereço seja NULL, é o ultimo valor que será removido
	sw s3, (s4)
	la a0, msg_rm_sucesso #mensagem que removeu com sucesso
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	la a0, msg_numero_removido
	li a7, 4
	ecall
	add a0, zero, s5
	li a7, 1
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	jal limpa_reg #chama função para limpar os registradores 
	addi t1, t1, -1 #decrementa 1 da quantidade atual de elementos
	addi a1, a1, 1 #faz incremento para mensagem final
	j lista_opcoes
	
rem_ultimo: #função que remove o ultimo elemento, apagando o valor, e desalocando seu espaço
	sw zero, (s4)
	addi sp, sp, 8
	add s1, zero, s4
	la a0, vlr_ult_rem
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	addi t1, t1, -1
	addi a1, a1, 1
	jal limpa_reg
	j lista_opcoes
	
remove_prim: #função que remove o primeiro elemento da lista, mudando o end inicial da lista para o próximo
	lw s5, 4(s0)
	add s0, zero, s5
	add s2, zero, s5
	add s3, zero, s5
	la a0, vlr_prim_rem
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	jal limpa_reg
	addi t1, t1, -1
	addi a1, a1, 1
	j lista_opcoes
	
valor_acima: #mensagem de erro caso o valor informado seja superior ao numero de elementos na lista
	la a0, msg_indice_maior
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	jal lmp_reg
	j lista_opcoes

lmp_reg: #função para limpar os registradores usados
	add s3, zero, s0
	add s5, zero, zero
	add s6, zero, zero
	add s7, zero, zero
	add s8, zero, zero
	add s9, zero, zero
	addi s10, zero, 1
	add t3, zero, zero
	ret
	
#############################################################################################
#começa funcao para imprimir a lista
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
	
fimlistagem: #quebra linha e volta para o menu após terminar de listar os elementos
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
#funcao para finalizar o programa, informando a quantidade de elementos inseridos e removidos, conforme foi solicitado no trabalho	
end:
	la a0, msg_final
	li a7, 4
	ecall
	add a0, zero, t0
	li a7, 1
	ecall
	la a0, msg_final_1
	li a7, 4
	ecall
	add a0, zero, a1
	li a7, 1
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	nop
	ebreak
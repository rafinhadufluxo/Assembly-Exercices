# 1 ) Implementar um programa usando o conjunto de instruções RV32I que contém duas funções. 
# Uma função para contar o número de vogais em uma determinada string e, outra função que recebe 
# a posição inicial de uma string e elimina todas as vogais presentes na mesma. Considere somente 
# minusculas (Exemplo: entrada - "isto eh uma string" saída: "st h m strng"). 

# - int conta_vogais (char string[0]);
# - char &string[0] elimina_vogais(char &string[0]);

# O programa principal deve fazer a chamada das duas funções passando o endereço de uma string para as 
# mesmas. O programa deve mostrar para o usuário a quantidade de vogais e as strings com e sem as vogais.


def elimina_vogais(string):
   
    string = str(string)
    vowel = "aeiouAEIOU"
    for i in vowel:
        string = string.replace(i,"")
    return string
    

def conta_vogais(string):
    string = string.lower() # para que a comparação não seja sensível a maiuscula/minuscula
    result = 0
    vogais = 'aeiou'
    for i in vogais:
        result += string.count(i)
    return result


#================ inicio do programa ================

frase = input("informe uma frase: ")

print("\nFRASE INFORMADA: ", frase)
print("ELIMINANDO VOGAIS: ",elimina_vogais(frase))
print("Total de vogais ", conta_vogais(frase))
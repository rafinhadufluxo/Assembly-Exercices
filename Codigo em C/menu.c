#include <stdio.h>
#include <stdlib.h>


typedef struct elemeto {
    int info;
    struct elemeto *prox;
}Elemento;
Elemento* lista_cria(void){
    return NULL;
}

Elemento* lista_insere(Elemento* lista, int valor){
    Elemento *novo;
    novo = (Elemento*)malloc(sizeof(Elemento));
    novo->info = valor;
    novo->prox = lista;
    return novo;
}

void lista_imprime(Elemento* lista){
    Elemento *p;
    for(p=lista ; p!= NULL ; p=p->prox){
        printf("Info = %d\n", p->info);
    }
}

int lista_vazia(Elemento* lista){
    return(lista == NULL);
}

Elemento* busca(Elemento* lista, int v){
    Elemento *p;
    for(p=lista ; p!= NULL ; p=p->prox){
        if(p->info == v)
            return p;
    }
    return NULL;
}


Elemento* lista_retira(Elemento* lista, int valor){
    // ponteiro para elemento anterior
    Elemento *ant = NULL;
    // ponteiro para percorrer a lista
    Elemento *p = lista;
    //ponteiro para atualizar a lista
    Elemento *resultado  = lista;


    //Procurando o elemento na lista e guardando o anterior
    while(p!=NULL && p->info!=valor){
        ant = p;
        p = p->prox;

    }


    // verifica se achou elemento
    if(p == NULL)
        // nao achou nenhum elemento, retorna lista original
        return resultado;

    if(ant == NULL)
        // retira o elemento do inicio
        resultado = p->prox;

    free(p);
    return resultado;

}

Elemento* lista_ordenada(Elemento* lista, int valor){

    Elemento* novo;
    //ponteiro para elemento anterior
    Elemento *ant =  NULL;
    //ponteiro para percorrer a lista
    Elemento *p = lista;
    // ponteiro para a lista atualizada
    Elemento *resultado = lista;

    //Procurando posicao de insercao
    while(p!=NULL && p->info < valor){
        ant = p;
        p->prox;
    }

    //cria elemento de insercao
    novo = (Elemento*)malloc(sizeof(Elemento));
    novo->info = valor;

    //Encadeia elemento
    if(ant == NULL){
        novo->prox = lista;
        resultado = novo;
    }
    else{
        // insere valor no meio da lista
        novo->prox = ant->prox;
        ant->prox = novo;

    }
    return resultado;
}

void lista_libera(Elemento* lista){
    Elemento *p;
    Elemento *t;

    p = lista;
    while(p!= NULL){
            //Guardando a referencia para o proximo elemento
            t = p->prox;
            // libera a memoria apontada por p
            free(p);
            // faz apontar para prox
            p=t;

    }
}
// Elemento* lista_cria(void);

// Elemento* lista_insere(Elemento* lista, int valor);

// void lista_imprime(Elemento* lista);

// int lista_vazia(Elemento* lista);

// Elemento* busca(Elemento* lista, int v);

// Elemento* lista_retira(Elemento* lista, int val);

// void lista_libera(Elemento* lista);

Elemento* lista_ordenado(Elemento* lista, int val);

int lista_igual(Elemento* lista1, Elemento* lista2);


int main()
{
    Elemento *lista;
    int n, valor, opc,ox=0;

    do{
        printf("\n========= MENU =========\n");
        printf("1 - Cria  Lista\n");
        printf("2 - Verifica se a lista esta vazia\n");
        printf("3 - Insere um valor na Lista\n");
        printf("4 - Imprime Lista\n");
        printf("5 - Busca valor da lista\n");
        printf("6 - Retirar valor ordenados na lista\n");
        printf("7 - Inserir valores ordenados na lista\n");
        printf("8 - Igualdade de lista\n");
        printf("9 - Liberar lista\n");
        printf("10 - Sair\n");

        printf("Selecione uma opcao: ");
        scanf("%d", &opc);

        switch(opc){
        case 1:
            lista = lista_cria();
            break;
        case 2:
            n = lista_vazia(lista);
            printf("A lista esta vazia? %d\n", ox);
            break;
        case 3:
            printf("\nDigite um valor para ser inserido na lista: ");
            scanf("%d", &valor);
            lista = lista_insere(lista, valor);
            ox+=1;
            break;
        case 4:
            lista_imprime(lista);
            break;
        case 5:
            printf("\nDigite o valor a ser buscado na lista: ");
            scanf("%d", &valor);
            lista = busca(lista, valor);
            break;
        case 6:
            printf("\nDigite o valor a ser retirado da lista: ");
            scanf("%d", &valor);
            lista = lista_retira(lista, valor);
            ox-=1;
            break;
        case 7:
            printf("\nDigite um valor para ser inserido na lista: ");
            scanf("%d", &valor);
            ox+=1;
//            lista = lista_ordenado(lista, valor);

            break;
        case 9:
            lista_libera(lista);
            break;
        }
    }while(opc != 10);
    return 0;
}
# MyMalloc
Uma implementação da função ```malloc()``` na linguagem assembly da família AMD64. O objetivo é possuir uma gama de implementações de diferentes qualidades.
## Observações importantes
### Compilando Assembly
- as arquivo.s -o arquivo.o
- ld arquivo.o -o arquivo
### Chamando funções assembly em C
- Usar *globl* antes de toda função
- Compilar com gcc -o arquivo1.c arquivo2.s
- Não utilizar *_start* caso haja um procedimento ```main```

## Primeira implementação
### A implementação ingênua
```c
  void iniciaAlocador();
  void finalizaAlocador();
  void* alocaMem(int tam);
```
A implementação é ruim por considerar que a secção heap é infinita, sem reaproveitar nenhum espaço de memória.
## Segunda implementação
- Uma única lista encadeada.

```c
typedef struct{
  int ocupado;
  int tamanho;
  nodo* proximo;
} nodo;

void iniciaAlocador();

void finalizaAlocador();

void* alocaMem(int tam);

void desalocaMem();
```
Uma implementação melhor.

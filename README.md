# Trabalho Software Básico
- [x] Funções sem variáveis locais e sem parâmetros
- [x] Funções com variáveis locais e sem parâmetros
- [ ] Funções com variáveis locais e com parâmetros
- [ ] Funções com recursão
- [ ] Entender enunciado

## Observações importantes
### Compilando Assembly
- as arquivo.s -o arquivo.o
- ld arquivo.o -o arquivo
### Chamando funções assembly em C
- Usar *globl* antes de toda função
- Compilar com gcc -o arquivo1.c arquivo2.s

## Primeira implementação
- Uma única lista encadeada.

```c
typedef struct{
  int ocupado;
  int tamanho;
  nodo* proximo;
} nodo;

void inicia_alocador(){

}

void encerra_alocador(){

}

void aloca(){

}

void desaloca()
```

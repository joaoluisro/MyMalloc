#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern void iniciaAlocador();
extern void finalizaAlocador();
extern void* alocaMem(long int x);
extern void* alturabrk();
extern void desalocaMem(void *x);

void imprime(void *x){
  printf("ender : %x\n",x);
  printf("prox = %x\n", *(long int*)(x - sizeof(long int)));
  printf("tam = %ld\n", *(long int*)(x - 2*sizeof(long int)));
  printf("val = %ld\n", *(long int*)(x - 3*sizeof(long int)));
  printf("\n");
}

int main(){
  void *x;
  void *b;
  void *z;
  void *y;
  printf("\n");
  iniciaAlocador();
  x = alocaMem(8);
  imprime(x);
  y = alocaMem(16);
  imprime(y);
  z = alocaMem(24);
  imprime(z);
  desalocaMem(y);
  b = alocaMem(12);
  imprime(b);
  finalizaAlocador();
  printf("\n");
}

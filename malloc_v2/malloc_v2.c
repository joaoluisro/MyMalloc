#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern void iniciaAlocador();
extern void finalizaAlocador();
extern void* alocaMem(long int x);
extern void* alturabrk();
extern void desalocaMem(void *x);

int main(){
  void *x;
  void *b;
  void *y = x;
  printf("\n");
  iniciaAlocador();
  x = alocaMem(8);
  //strcpy(x,"abba");
  printf("x : %x\n",x);
  printf("x.prox = %x\n", *(long int*)(x - sizeof(long int)));
  printf("x.tam = %ld\n", *(long int*)(x - 2*sizeof(long int)));
  printf("x.val = %ld\n", *(long int*)(x - 3*sizeof(long int)));
  y = alocaMem(8);

  printf("\n");
  printf("y : %x\n",y);
  printf("y.prox = %x\n", *(long int*)(y - sizeof(long int)));
  printf("y.tam = %ld\n", *(long int*)(y - 2*sizeof(long int)));
  printf("y.val = %ld\n", *(long int*)(y - 3*sizeof(long int)));
  printf("\n");
  b = alocaMem(8);
  printf("b : %x\n",b);

  printf("altura : %x\n",alturabrk());
  finalizaAlocador();
  printf("altura final: %x\n",alturabrk());

}

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern void iniciaAlocador();
extern void finalizaAlocador();
extern void* alocaMem(long int x);
extern void* alturabrk();
extern void desalocaMem(void *x);
extern long int tam_dis();
extern long int end_cor();
extern long int ret_tail();
extern long int ret_head();

void imprime(void *x){
  printf("ender : %x\n",x);
  printf("prox = %x\n", *(long int*)(x - sizeof(long int)));
  printf("tam = %ld\n", *(long int*)(x - 2*sizeof(long int)));
  printf("val = %ld\n", *(long int*)(x - 3*sizeof(long int)));
  //printf("tam disponivel : %ld\n", tam_dis());
  printf("\n");
}

int main(){
  void *x;
  void *b;
  void *z;
  void *y;
  printf("\n");
  iniciaAlocador();
  x = alocaMem(2000);
  y = alocaMem(1000);
  z = alocaMem(300);
  b = alocaMem(2000);
  imprime(x);
  imprime(y);
  imprime(z);
  imprime(b);
  desalocaMem(y);
  desalocaMem(b);
  desalocaMem(z);
  //b = alocaMem(200);
  //void *t = alocaMem(10000);
  printf("%x\n",ret_tail());
  printf("%x\n",ret_head());
  imprime(x);
  imprime(y);
  imprime(z);
  imprime(b);
  //imprime(z);
  //imprime(t);
  finalizaAlocador();
  printf("\n");
}

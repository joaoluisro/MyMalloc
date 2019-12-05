#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern void iniciaAlocador();
extern void finalizaAlocador();
extern void* alocaMem(long int x);
extern void* alturabrk();
extern void desalocaMem(void *x);
extern long int ret_tail();
extern long int ret_head();
void imprime(void *x){
  printf("ender : %x\n",x);
  printf("prox = %x\n", *(long int*)(x - sizeof(long int)));
  printf("tam = %ld\n", *(long int*)(x - 2*sizeof(long int)));
  printf("val = %ld\n", *(long int*)(x - 3*sizeof(long int)));
  printf("\n");
}

void mapa(){
  void *tail = ret_tail();
  void *head = ret_head();
  void *aux = head;
  long int tam = 0;
  int j = 1;
  printf("\n");
  printf("Mapa da Heap\n");
  while(aux <= tail){
    tam = *(long int *)(aux - 2*sizeof(long int));
    //printf("bloco %d\n", j);
    if(*(long int*)(aux - 3*sizeof(long int)) == 0){
      printf("%d) -",j);
    }
    else{
      printf("%d) +",j);
    }
    printf(" =>  ");
    for(int i=0;i < tam;i++){
      printf("#");
    }
    printf(" \n");
    aux = *(long int*)(aux - sizeof(long int));
    j++;
  }
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
  //imprime(y);
  z = alocaMem(24);
  imprime(z);
  desalocaMem(y);
  b = alocaMem(12);
  imprime(b);
  printf("%x | %x \n",ret_tail(),ret_head());
  mapa();
  finalizaAlocador();
  printf("\n");
}

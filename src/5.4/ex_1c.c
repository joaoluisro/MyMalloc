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
  x = alocaMem(5);
  y = alocaMem(6);
  z = alocaMem(3);
  b = alocaMem(4);
  //imprime(x);
  //imprime(y);
  //imprime(z);
  //imprime(b);

  desalocaMem(y);

  //desalocaMem(b);
  desalocaMem(z);
  mapa();
  void *t = alocaMem(7);
  //b = alocaMem(200);
  //void *t = alocaMem(10000);
  //printf("%x\n",ret_tail());
  //printf("%x\n",ret_head());
  //imprime(x);
  //imprime(y);
  //imprime(z);
  //imprime(b);
  //imprime(z);
  //imprime(t);
  mapa();
  finalizaAlocador();
  printf("\n");
}

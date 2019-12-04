#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern void iniciaAlocador();
extern void finalizaAlocador();
extern void* alocaMem(long int x);
extern void* alturabrk();

int main(){
  void *x;
  void *b;
  void *y = x;
  printf("\n");
  printf("altura inicial %x\n",alturabrk());
  iniciaAlocador();
  printf("altura atual: %x\n", alturabrk());
  x = alocaMem(100);
  printf("altura atual: %x\n",alturabrk());
  finalizaAlocador();
  printf("altura final: %x\n",alturabrk());
  /*
  alturabrk();
  iniciaAlocador();
  alturabrk();
  printf("altura inicial %x\n",alturabrk());
  x = alocaMem(100);
  printf("ender x : %x\n",x);
  printf("altura atual : %x\n",alturabrk());
  //y = alocaMem(200);
  //printf("ender y : %x\n",y);
  //printf("%x\n",alturabrk());
  finalizaAlocador();
  printf("altura final : %x\n",alturabrk());
  //printf("%x\n",alturabrk());
  /*
  printf("BRK: %x\n", alturabrk());
  x = alocaMem(10);
  printf("BRK: %x\n", alturabrk());
  strcpy(x, "ABC");
  void *y = x;
  while(*(char *)y != '\0'){
    printf("%c  ", *(char*)y);
    printf("%x\n", y);
    y += sizeof(char);
  }
  printf("BRK: %x\n",alturabrk());
  printf("Inicio Heap: %x\n",a);
  printf("diff : %x \n", b - a);
  //printf("%s\n",x);
  //printf("%X\n",&(x));
  //Pintf("%s\n",*(&(x))
  printf("BRK: %x\n", alturabrk());

  //finalizaAlocador();
  void *z = alocaMem(100);
  printf("BRK: %x\n", alturabrk());
  printf("diff : %x \n", alturabrk() - b);
  void *u = alocaMem(100);
    printf("BRK: %x\n", alturabrk());
  //printf("BRK: %x\n", alturabrk());
  strcpy(u,"abba");
  y = u;
  while(*(char *)y != '\0'){
    printf("%c  ", *(char*)y);
    printf("%x\n", y);
    y += sizeof(char);
  }
  printf("BRK: %x\n", alturabrk());
  return 0;
  */
}

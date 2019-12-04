#include <stdio.h>
#include <string.h>
extern void iniciaAlocador();
extern void finalizaAlocador();
extern int alocaMem(int x);

int main(){
  void *x;
  x = alocaMem(100);
  strcpy(x, "alo mocidade");
  printf("%s\n",x);
  return 0;
}

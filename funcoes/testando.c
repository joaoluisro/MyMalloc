#include <stdio.h>

extern long int f();

int main(){
  int a,b;
  a = 2;
  b = 3;
  long int c;
  c = f();
  printf("%ld", c);

}

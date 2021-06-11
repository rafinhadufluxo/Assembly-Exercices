#include <stdio.h>

int main(){
  int n=0, fatorial;

  printf("Entre o valor de n\n");
  scanf("%d", &n);

  fatorial = 1;

  while (n > 0) {
    fatorial = fatorial *  n;
    n--;                /* equivalente a:  n = n-1    */
  }

  printf("%d! = %d\n", n, fatorial);

  return 0;
}
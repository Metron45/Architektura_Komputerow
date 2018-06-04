#include <stdio.h>
#include <stdlib.h>

int dodaj(int a, int b);
int a = 1;
int b = 2;
int wynik;

int main() {
printf("Start\n") ;
wynik = dodaj(a,b);
printf(" %d + %d = %d\n",a,b,wynik);
}

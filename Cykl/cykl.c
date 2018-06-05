#include <stdio.h>
#include <stdlib.h>

int count();
int wynik;

int main() {
printf("Start\n");
wynik = count();
printf("test\n");
wynik = count() - wynik;
printf("Wynik: %d\n",wynik);

}

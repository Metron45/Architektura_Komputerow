# Program wywoluje funkcje dadania argumentów
# int dodaj(int x,int y)
# zwraca sume tych argumentow
.section .data

arg1:
.long 8
arg2:
.long 10


text_scan:
.ascii "%d\0"

text_print:
.ascii "Wynik: %d \n\0"

text_zacheta:
.ascii "Wprowadz liczbe: \n\0"



.section .text
.globl main
main:

pushl $text_zacheta
call printf

leal arg1, %eax
pushl %eax
pushl $text_scan
call scanf

leal arg2, %eax
pushl %eax
pushl $text_scan
call scanf

movl arg1, %eax
addl arg2, %eax

pushl %eax
pushl $text_print
call printf

movl %eax, %ebx
movl $1, %eax
int $0x80	#funkcja exit



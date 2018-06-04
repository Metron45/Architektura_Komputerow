# Program wywoluje funkcje dadania argumentów
# int dodaj(int x,int y)
# zwraca sume tych argumentow
.section .data

/*
arg1:
.long 8
arg2:
.long 10


.section .text
.globl main
main:

pushl arg1
pushl arg2
call func_dodaj

movl %eax, %ebx
movl $1, %eax
int $0x80	#funkcja exit
*/

.section .text
.globl dodaj
dodaj:

pushl %ebp		
movl %esp, %ebp		
pushl %ebx	

movl 8(%ebp), %eax	
movl 12(%ebp), %ebx	
addl %ebx, %eax	

popl %ebx		
popl %ebp		

ret			

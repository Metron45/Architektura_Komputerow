# Program pisze napis hello world i sie konczy
#
# Kompilacja:
# as hello_lib2.s -o hello_lib2.o
# gcc hello_lib2.o -o hello_lib2
#
#.align32
.section .data
helloworld:
.ascii "hello world\n\0"
.section .text
.globl main
main:
pushl $helloworld
call printf
pushl $0
call exit

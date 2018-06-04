# Przyklad uzycia funkcji printf z programu w assemblerze x86/x87
# parametr float zamieniany na double
# kompilacja:
# gcc printftest.s -o printftest –m32 -g
.section .data
formatstr: .ascii "float: %f \n\0"
liczba1:
.float 6.148
.text
.global main
main:
# Ladujemy liczba1 do st(0)
fld liczba1
# rezerwacja 8 bajtow na argument double
push %eax
push %eax
# przesylamy na stos zwykly liczba1 z st(0)
fstpl (%esp)
# przesylamy na stos adres formatstr
pushl $formatstr
# wywolujemy printf("float: %f\n",liczba1);
call printf
# cofamy stos
popl %ebx
popl %ebx
popl %ebx
ret

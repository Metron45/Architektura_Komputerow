# Funkcja pobiera kolejne elementy tablicy asm_mod_array
# dodaje do kazdego elementu 1
# Znaczenie rejestrow:
#
# %edi - indeks kolejnego elementu tablicy: 0,1,2,...,4
# %ecx - ilosc elementow tablicy
# %eax - wskaznik na poczatek tablicy
# %edx - pamiec tymczasowa
#
.code32
.section .text
.globl asm_mod_array
.type asm_mod_array, @function
asm_mod_array:
pushl %ebp
# zabezpieczamy stary %ebp
movl %esp, %ebp
# nowy base pointer = %esp (szczyt stosu)
movl 8(%ebp),%eax
# pierwszy par. – wsk. na pocz. tablicy do %eax
movl 12(%ebp),%ecx
# rozmiar tablicy do %ecx
xorl %edi, %edi
# zerujemy indeks biezacy w %edi
start_loop:
cmpl %edi, %ecx
je loop_exit
movl (%eax,%edi,4), %edx
addl $1, %edx
movl %edx, (%eax,%edi,4)
incl %edi
jmp start_loop #
loop_exit:
movl %ebp, %esp
popl %ebp
ret

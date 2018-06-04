SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDIN = 0
STDOUT = 1
EXIT_SUCCESS = 0
KEY = 4

.align 32

.data
msg_echo: .ascii "                                           "
msg_echo_len = . - msg_echo

newline: .ascii "\n"
newline_len = . - newline



.text
msg_hello: .ascii "Hello, world!\n"
msg_hello_len = . - msg_hello

.global _start                    # wskazanie punktu wejĹ›cia do programu
_start:
# piszemy msg_hello
mov $SYSWRITE, %eax             # funkcja do wywoĹ‚ania - SYSWRITE
mov $STDOUT, %ebx                 # 1 arg. - syst. deskryptor stdout
mov $msg_hello, %ecx             # 2 arg. - adres poczÄ…tkowy napisu
mov $msg_hello_len, %edx         # 3 arg. - dĹ‚ugoĹ›Ä‡ Ĺ‚aĹ„cucha
int $0x80                        # wywoĹ‚anie przerwania programowego -
                # wykonanie funcji systemowej.
# czytamy string do msg_echo
movl $SYSREAD, %eax             # funkcja do wywoĹ‚ania - SYSREAD
movl $STDIN, %ebx                 # 1 arg. - syst. deskryptor stdin
movl $msg_echo, %ecx             # 2 arg. - adres poczÄ…tkowy napisu
movl $msg_echo_len, %edx         # 3 arg. - dĹ‚ugoĹ›Ä‡ Ĺ‚aĹ„cucha
int $0x80           

# program zadania=========================================================

#Na_Duże======================================================
movl $0, %edi
movl $msg_echo_len, %ecx

loop:
decl %ecx
cmpl $0, %ecx
je endloop

mov msg_echo(,%edi,1), %al

cmpb $'a, %al
jl not_small

cmpb $'z, %al
jg not_small

sub $32, msg_echo(,%edi,1)

not_small:
incl %edi
jmp loop
endloop:

#Klucz_CEZARA====================================================
movl $0, %edi
movl $msg_echo_len, %ecx

loop2:

decl %ecx
cmpl $0, %ecx
je endloop2

mov msg_echo(,%edi,1), %al

cmpb $'A, %al
jl not_big
cmpb $'Z, %al
jg not_big

add $KEY, %al
mov %al, msg_echo(,%edi,1)

cmpb $'Z, %al
jle not_big

sub $26,msg_echo(,%edi,1)

not_big:

incl %edi
jmp loop2

endloop2:
#===============================================================

# wypisujemy na STDOUT msg_echo
movl $SYSWRITE, %eax        
movl $STDOUT, %ebx        
movl $msg_echo, %ecx             # 2 arg. - adres poczÄ…tkowy napisu
movl $msg_echo_len, %edx         # 3 arg. - dĹ‚ugoĹ›Ä‡ Ĺ‚aĹ„cucha
int $0x80           

# wypisujemy na STDOUT znak \n               
movl $SYSWRITE, %eax        
movl $STDOUT, %ebx        
movl $newline, %ecx             # 2 arg. - adres poczÄ…tkowy napisu
movl $newline_len, %edx         # 3 arg. - dĹ‚ugoĹ›Ä‡ Ĺ‚aĹ„cucha
int $0x80           

# zakonczenie programu
movl $SYSEXIT, %eax                # funkcja do wywoĹ‚ania - SYSEXIT
movl $EXIT_SUCCESS, %ebx         # 1 arg. -- kod wyjĹ›cia z programu
int $0x80                        # wywoĹ‚anie przerwania programowego -
                                # wykonanie funcji systemowej.

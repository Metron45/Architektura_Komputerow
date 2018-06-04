SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDIN = 0
STDOUT = 1
EXIT_SUCCESS = 0

.align 32

.data
msg_echo: .ascii "                                           "
msg_echo_len = . - msg_echo

threeBytes: .ascii "   "
 
newline: .ascii "\n"
newline_len = . - newline

.lcomm oneByte, 1

.text
msg_hello: .ascii "Hello, world!\n"
msg_hello_len = . - msg_hello

.global _start			# wskazanie punktu wejścia do programu
_start:

#poczatek pentli
loop:


# czytamy string do msg_echo
movl $SYSREAD, %eax 		# funkcja do wywołania - SYSREAD
movl $STDIN, %ebx 		# 1 arg. - syst. deskryptor stdin
movl $oneByte, %ecx 		# 2 arg. - adres początkowy napisu
movl $1, %edx 	# 3 arg. - długość łańcucha
int $0x80			

#warunek konca pentli

cmpl $1, %eax
jne endloop

			#Kod ostatnich 4 bitów
mov oneByte, %al
and $0b00001111, %al

cmpb $9, %al
jle number_low	

add $55, %al
jmp done_low

number_low:	
add $'0, %al
done_low:

movl $2, %edi
mov %al, threeBytes(,%edi,1)

			#Kod pierwszych 4 bajtów
mov oneByte, %al
and $0b11110000, %al
rcr $4,%al

cmpb $9, %al
jle number_high	

add $55, %al
jmp done_high

number_high:	
add $'0, %al
done_high:

movl $1, %edi
mov %al, threeBytes(,%edi,1)



# wypisujemy na STDOUT msg_echo
movl $SYSWRITE, %eax 		
movl $STDOUT, %ebx 		
movl $threeBytes, %ecx 		# 2 arg. - adres początkowy napisu
movl $3, %edx 	# 3 arg. - długość łańcucha
int $0x80			

#koniec pentli
jmp loop
endloop:

# wypisujemy na STDOUT znak \n				
movl $SYSWRITE, %eax 		
movl $STDOUT, %ebx 		
movl $newline, %ecx 		# 2 arg. - adres początkowy napisu
movl $newline_len, %edx 	# 3 arg. - długość łańcucha
int $0x80			

# zakonczenie programu
movl $SYSEXIT, %eax		# funkcja do wywołania - SYSEXIT
movl $EXIT_SUCCESS, %ebx 	# 1 arg. -- kod wyjścia z programu
int $0x80			# wywołanie przerwania programowego -
				# wykonanie funcji systemowej.



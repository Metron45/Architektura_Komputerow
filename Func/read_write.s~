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

newline: .ascii "\n"
newline_len = . - newline

.text
msg_hello: .ascii "Hello, world!\n"
msg_hello_len = . - msg_hello

.global main			# wskazanie punktu wejścia do programu
main:
# piszemy msg_hello
mov $SYSWRITE, %eax 		# funkcja do wywołania - SYSWRITE
mov $STDOUT, %ebx 		# 1 arg. - syst. deskryptor stdout
mov $msg_hello, %ecx 		# 2 arg. - adres początku napisu
mov $msg_hello_len, %edx 	# 3 arg. - długość łańcucha
int $0x80			# wywołanie przerwania programowego -
				# wykonanie funcji systemowej.

		
#wywołanie funkcji read
pushl $msg_echo_len
pushl $msg_echo
pushl $STDIN
call read

#wywołanie funkcji write
pushl $msg_echo_len
pushl $msg_echo
pushl $STDOUT
call write

#wywołanie funkcji exit
pushl $EXIT_SUCCESS
call exit


#===================Koniec MAIN, funkcje: ================

.type read, @function
read:
pushl %ebp		
movl %esp, %ebp	

# czytamy string do msg_echo
movl $SYSREAD, %eax 		# funkcja do wywołania - SYSREAD
movl 8(%ebp), %ebx 		# 1 arg. - syst. deskryptor stdin
movl 12(%ebp), %ecx 		# 2 arg. - adres początkowy napisu
movl 16(%ebp), %edx 		# 3 arg. - długość łańcucha
int $0x80

movl %ebp, %esp	
popl %ebp
ret

.type write, @function
write:
pushl %ebp		
movl %esp, %ebp	

# wypisujemy na STDOUT msg_echo
movl $SYSWRITE, %eax 		
movl 8(%ebp), %ebx 		
movl 12(%ebp), %ecx 		# 2 arg. - adres początkowy napisu
movl 16(%ebp), %edx 		# 3 arg. - długość łańcucha
int $0x80	

# wypisujemy na STDOUT znak \n				
movl $SYSWRITE, %eax 		
movl $STDOUT, %ebx 		
movl $newline, %ecx 		# 2 arg. - adres początkowy napisu
movl $newline_len, %edx 	# 3 arg. - długość łańcucha
int $0x80

movl %ebp, %esp	
popl %ebp
ret

.type exit, @function
exit:
pushl %ebp		
movl %esp, %ebp	

# zakonczenie programu
movl $SYSEXIT, %eax		# funkcja do wywołania - SYSEXIT
movl 8(%ebp), %ebx 		# 1 arg. -- kod wyjścia z programu
int $0x80			# wywołanie przerwania programowego -
				# wykonanie funcji systemowej.
movl %ebp, %esp	
popl %ebp
ret

.text
.globl count
count:
	pushl %ebx
	pushl %ecx
	pushl %edx
	
	 xor %eax, %eax 
	 cpuid 
	 rdtsc  
	 
	popl %ebx
	popl %ecx
	popl %edx
ret

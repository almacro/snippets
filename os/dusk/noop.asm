	section .text
	global _start
_start:
	mov eax, 1    		; exit
	int 0x80
	

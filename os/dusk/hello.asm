	BITS 16
	org 0x7c00
	mov ax, 0
	mov es, ax
	mov ah, 0x13  		; Function: Write string
	mov al, 0		; write mode, don't update cursor
	mov bh, 0 		; page number
	mov bl, 0xf		; color: white
	mov cx, 12 		; Number of characters to write
	mov dh, 0 		; Row
	mov dl, 0 		; Column
	mov bp, msg 		; Pointer to string
	int 0x10
loop:	jmp loop
msg:
	db 'Hello World!'
	times 510 -( $ - $$ ) db 0
	db 0x55, 0xaa

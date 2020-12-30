use16
org 0x100

Number dw 0
mov bl, 3

mov ah, 0x09
mov dx, str_1
int 21h
xor dh, dh

mov [Number], 0xABCD
mov cl, 4
jmp m3

m4:
	mov ah, 0x09
	mov dx, str_2
	int 21h
	xor dh, dh
	
	mov [Number], 0x1234
	xor bl, bl
	mov cl, 4

m3:
	mov ax, [Number]
	and ax, 0xf000
	shr ax, 12
	mov dl, al
	cmp dl, 0x09
	ja m1
	add  dl, 0x30
	jmp m2

m1:
	add dl, 0x37

m2:
	mov ah, 0x2
	int 0x21
	xor dx, dx
	
	mov ax, [Number]
	shl ax, 4
	mov [Number], ax
	
loop m3

cmp bl, 0
jne m4

str_1: 
	db 'AX=0x', '$'
str_2: 
	db 0xA, 0xD, 'BX=0x', '$'

int 16h
int 20h
use16
org 0x100
mov ax, 0x31
mov es ,ax
mov di, 0
mov cx, 16
l_strings:
	push cx ;
	mov cx, 16
	l_columns:
		push cx ; 
		xor ax, ax
		mov al, [es:di]
		mov [ds:number], al
		mov cx, 2
		mbeginloop: ; 
			push cx ; 
			xor dh, dh
			mov dl, [ds:number]
			and al, 0xf0
			shr al, 4
			mov dl, al
			cmp dl, 0xA
			jb mdigit
			add dl, 0x37
			jmp mletter
		mdigit: ; working with digit
			add dl, 0x30
		mletter: ; working with letter
			mov ah, 02
			int 0x21
			pop cx ; 
		loop mbeginloop
		mov ah, 0x9
		mov dx, s_test
		int 0x21
		inc di
		pop cx
	loop l_columns
	mov ah, 0x9
	mov dx, s_enter
	int 0x21
	pop cx
loop l_strings
int 0x20

s_test db ' ','$'
s_enter db 0xD, 0xA, '$'
number db 0
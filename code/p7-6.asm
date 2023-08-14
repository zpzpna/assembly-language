assume cs:code,ds:data

data segment

	db 'BaSiC'
	db 'MinIX'
	
data ends

code segment
; 将第一个字符串变大写，第二个变小写。（通过设置高位第三位二进制）
start:	mov ax,data
		mov ds,ax
		mov si,0
		
		mov cx,5
	s:	mov al,ds:0[si]
		and al,11011111b
		mov ds:0[si],al
		
		mov al,ds:5[si]
		or al,00100000b
		mov ds:5[si],al
		
		inc si
		loop s
		
		mov ax,4c00h
		int 21h

code ends

end start
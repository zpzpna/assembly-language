assume cs:code,ds:data

data segment
	
	db 'Welcome to masm!'
	db '................'
	
data ends

code segment
;将第一段字符串复制到第二段字符串中
start:	mov ax,data
		mov ds,ax
		mov si,0
		mov di,16
		mov bx,0
		
		mov cx,16
	s:	mov al,ds:[bx+si]
		mov ds:[bx+di],al
		
		inc bx
		loop s
		
		mov ax,4c00h
		int 21h
		
code ends

end start
assume cs:code

a segment

	db 1,2,3,4,5,6,7,8
	
a ends

b segment

	db 1,2,3,4,5,6,7,8
	
b ends

c segment

	db 0,0,0,0,0,0,0,0
	
c ends

code segment

start:	mov ax,c	;c段地址存在es段寄存器
		mov es,ax
		
		mov bx,0
		mov cx,8
		
	s:	mov ax,a	;ds段寄存器循环读取a,b段，取出数据存入c段对应位置
		mov ds,ax
		mov al,ds:[bx]
		add es:[bx],al
		
		mov ax,b
		mov ds,ax
		mov al,ds:[bx]
		add es:[bx],al
		
		add bx,1
		loop s
		
		mov ax,4c00h
		int 21h
code ends

end start
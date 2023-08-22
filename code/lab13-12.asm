assume cs:code,ss:stack

stack segment
	dw 16 dup (0)
stack ends

code segment
	start:
	
		mov ax,stack
		mov ss,ax
		mov sp,20h
		
		mov ax,0b800h
		mov es,ax
		mov di,160*12
		
		mov bx,offset s - offset se
		mov cx,80
	s:
		mov byte ptr es:[di],'!'
		add di,2
		int 7ch
	se: 
		nop
		
		mov ax,4c00h
		int 21h
	
code ends

end start
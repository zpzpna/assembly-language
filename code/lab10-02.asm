assume cs:code,ss:stack

stack segment
	db 16 dup (0)
stack ends

code segment
;设计一个不会除法溢出的子程序，并调用,手算样例找分配规律
	start:	mov ax,stack
			mov ss,ax
			mov sp,10h
			;例子 10000/10
			mov ax,4240h
			mov dx,000Fh
			mov cx,0ah
			call divdw
			
			mov ax,4c00h
			int 21h
			
	divdw:	push ax
			mov ax,dx
			mov dx,0
			div cx
			mov bx,ax	;结果高16位
			
			pop ax
			div cx		;此时ax为商的低16位
			mov cx,dx	;余数
			mov dx,bx
			ret
			
code ends

end start
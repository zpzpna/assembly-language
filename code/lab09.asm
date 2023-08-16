assume cs:code,ds:data,ss:stack

data segment

	db 'welcome to masm!'
	db 00000010b,00100100b,01110001b
	
data ends

stack segment
	db 16 dup (0)
stack ends

code segment

;配置数据栈和显示栈和栈
start:	mov ax,data
		mov ds,ax
		mov bx,0
		;如果开头行设置0b80ah，则不需要尾部循环输出也可以看到第一行的绿色字体
		;若开头不设置，尾巴不循环，则第一行绿色无法看见
		mov ax,0b800h
		mov es,ax
		mov di,0

		
		mov ax,stack
		mov	ss,ax
		mov sp,16
;三次循环输出三句话		
		mov cx,3
		mov si,0
	s:	push cx
		mov cx,16
		mov bx,0
		mov di,0
		mov ah,ds:[si+16]
		
	s1:	mov al,ds:[bx]
		mov es:[di],ax
		inc bx
		add di,2
		loop s1
		
		pop cx
		inc si
		mov dx,es	;换行
		add dx,0ah
		mov es,dx
		loop s
		;设置死循环，刷新输出，可以看第一句绿色
		flash:	
		jmp short flash
		
		mov ax,4c00h
		int 21h
		

code ends

end start


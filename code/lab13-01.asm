assume cs:code

code segment
	start:
		;中断处理程序
		mov ax,cs
		mov ds,ax
		mov si,offset print_pre 
		
		mov ax,0
		mov es,ax
		mov di,0200h
		
		mov cx,offset print_ef - offset print
		rep movsb
		;中断向量设置
		mov ax,0
		mov ds,ax
		mov word ptr ds:[7ch*4+0],0200h
		mov word ptr ds:[7ch*4+2],0
		
		mov ax,4c00h
		int 21h
	;中断例程
	print:
	;功能：显示0结尾的字符串
	;参数：dh-行号，dl-列号，cl-颜色，ds:si指向字符串首地址
	print_pre:
		push si
		push ax
		push es
		push di
		push cx
		push bx
		
		mov ah,cl
		mov si,0
	print_sta:

		;定位行列
		mov bx,0b800h
		mov es,bx
		mov di,0

		mov ch,0
		mov cl,dh
		mov bx,es
	row:add bx,10
		loop row
		mov es,bx

		mov cl,dl
	col:add di,2
		loop col
		
	;输出屏幕
	s:	mov al,ds:[si]
		cmp al,0
		je print_end
		
		mov es:[di],ax
		inc si
		add di,2
		jmp short s
	print_end:
		pop bx
		pop cx
		pop di
		pop es
		pop ax
		pop si
		iret
	
	print_ef:
		nop
code ends

end start
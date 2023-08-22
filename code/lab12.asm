assume cs:code

code segment

	start:
		;设置中断处理程序安装源地址和目的地址
		mov ax,cs
		mov ds,ax
		mov si,offset do0
		
		mov ax,0
		mov es,ax
		mov di,200h
		
		mov cx,offset do0_end - offset do0
		cld
		rep movsb
		
		mov ax,0
		mov es,ax
		mov word ptr es:[4*0],0200h
		mov word ptr es:[4*0+2],0
		
		mov ax,4c00h
		int 21h
	
	do0:
	do0_pre:
		jmp short do0_sta
		db 'divide error!'
	do0_sta:
		mov ax,0b80h
		mov es,ax
		mov di,160*12+80
		
		mov ax,cs
		mov ds,ax
		mov si,202h
		
		mov cx,13
		rep movsb
		
		mov ax,4c00h
		int 21h
		
	do0_end:
		nop

		
code ends

end start
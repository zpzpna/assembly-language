assume cs:code

code segment
	
	start:
		mov ax,cs
		mov ds,ax
		mov si,offset lp
		
		mov ax,0
		mov es,ax
		mov di,200h
		
		mov cx,offset lp_ee - offset lp
		rep movsb
		
		mov ax,0
		mov es,ax
		mov word ptr es:[7ch*4],200h
		mov word ptr es:[7ch*4+2],0
		
		mov ax,4c00h
		int 21h
	
	lp:
	;功能:实现循环
	;参数：cx-循环次数，bx-循环位移
	;实现：本质上是实现每次循环操作最后判断是跳转循环开头还是结束。通过操作栈段保存的ip值
	lp_pre:
		push bp
	lp_sta:
		mov bp,sp
		dec cx
		jcxz lp_end
		add ss:[bp+2],bx
	lp_end:
		pop bp
		iret
	lp_ee:
		nop
code ends

end start
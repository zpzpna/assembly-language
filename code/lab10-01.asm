assume cs:code,ds:data,ss:stack

data segment
	db 'welcome to masm!',0
data ends

stack segment
	dw 16 dup (0)
stack ends

code segment
	;在指定位置指定颜色输出数据段字符串
	;变量: dh:行号 | dl:列号 | cl:颜色
	start:	mov dh,8
			mov dl,3
			mov cl,2
			
			mov ax,data
			mov ds,ax
			mov si,0
			
			mov ax,stack
			mov ss,ax
			mov sp,20h
			
			call show_str
			
			mov ax,4c00h
			int 21h
			
	show_str:
	show_str_pre:
			push si
			push ax
			push es
			push di
			
	show_str_sta:		
			push cx
			mov si,0
			;算出显示地址
			mov ax,0b800h
			mov es,ax
			mov di,0
			;处理行地址
			mov cl,dh
			mov ch,0
			
			mov ax,es
	row:	add ax,0ah
			loop row
			mov es,ax
			;处理列地址
			mov cl,dl
			mov ch,0
	col:	add di,2
			loop col
			
			pop ax
			mov ah,al
	change:	mov cl,ds:[si]
			jcxz show_str_end
			mov al,cl
			mov es:[di],ax
			add di,2
			inc si
			jmp short change
	
	show_str_end:	
			pop di
			pop es
			pop ax
			pop si
			ret
code ends

end start
assume cs:code,ds:data,ss:stack

stack segment
	dw 0,0,0,0,0,0,0,0
stack ends

data segment
	db '1.display       '
	db '2.brows         '
	db '3.replace       '
	db '4.modify        '
data ends

code segment
; 每个单词前四位改大写
	start:	mov ax,stack
			mov ss,ax
			mov sp,16
			
			mov ax,data
			mov ds,ax
			mov bx,0	;外层变量	
			
			mov cx,4
		s0:	push cx
			mov si,0 	;内层变量
			
			mov cx,4
		s1:	mov al,ds:[bx+si+2] ;注意是al不是ax，字符一个只占1b单元
			and al,11011111b
			mov ds:[bx+si+2],al
			
			inc si
			loop s1
			
			add bx,16
			pop cx
			loop s0
			
			mov ax,4c00h
			int 21h
			
code ends

end start
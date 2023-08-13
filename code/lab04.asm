assume cs:code

; purpose:向内存0:200-0:23F,传输数据0-63（3FH）

code segment

	; 0:200-0:23F -> 020:0-020:3F,设置bx来同步计数
	
	mov ax,20h
	mov ds,ax
	mov bl,0	; 注意：传入内存单元是1B一个单元，所以用低位寄存器
	
	mov cx,64
	
s:	mov ds:[bl],bl
	inc bl
	loop s
	
	mov ax,4c00h
	int 21h
	
	
code ends

end
assume cs:code,ds:data,ss:stack

data segment
	
	dw 8 dup (0)
	;dw 123,12666,1,8,3,38
	;注意，本代码只实现了对某一个数字的十进制转化子程序，如果要连续转化并输出
	;思路大致为：ds:si处所有数据传输到es:di,每次取一个es:di处的数据用子程序转化为字符串
	;放在ds:si处后输出，循环输出直到输出所有数字
	
	;实验10中子程序02没有分开子程序为三段，导致抽象程度不高，耦合性强
	;10-03子程序通过将子程序分成三段，降低了子程序和其他汇编的耦合，但是要用到大量栈空间
	;即使不压入栈，栈中也存放部分信息，不能用sp直接移动索引！！！会破坏栈段	
	
	;变量不用push pop来保存回复
data ends

stack segment
	dw 16 dup (0)
stack ends

code segment

	start:	mov ax,12666
			mov bx,data
			mov ds,bx
			mov si,0
			
			mov bx,stack
			mov ss,bx
			mov sp,20h
			
			call dtoc
			
			mov dh,8
			mov dl,3
			mov cl,2
			call show_str
			
			mov ax,4c00h
			int 21h
			
	dtoc:
	;功能：将数字转化为10进制数字符串并输出
	;变量：ax:每次处理的字型数据 | ds:si,每次转换的字符串起始位
	dtoc_pre:	;push 外部变量
			push dx
			push bx
			push si
			push cx
			
			mov si,0
	dtoc_sta_in:	;计算数字对应的字符串并存储
			;逆序压字符串入栈
			mov dx,0
			mov bx,10
			
			div bx
			add dx,30h
			push dx
			inc si
			
			mov cx,ax
			jcxz dtoc_sta_out
			jmp short dtoc_sta_in
			
	dtoc_sta_out:		;顺序出栈存入ds:si
			mov cx,si
			mov si,0
			
		s0:	pop dx
			mov ds:[si],dl
			
			inc si
			loop s0
			
	dtoc_end:	;回复外部变量
			pop cx
			pop si
			pop bx
			pop dx
			
			ret
			
	show_str:
	;功能：在指定位置指定颜色输出数据段字符串
	;变量: dh:行号 | dl:列号 | cl:颜色
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
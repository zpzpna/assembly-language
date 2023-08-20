assume cs:code,ds:data

data segment

	db "Beginner's All-purpose Symbolic Instruction Code.",0

data ends

code segment

	start:	mov ax,data
			mov ds,ax
			mov si,0
			call letterc

			mov ax,4c00h
			int 21h

	letterc:
	;功能：将字符串中小写字母变为大写字母
	;参数：ds:si指向字符串首地址
	letterc_pre:
			push cx
			push si
			
			mov ch,0
	letterc_sta:
			mov cl,ds:[si]
			jcxz letterc_end
			
			;选择范围为小写字母
			cmp cl,97
			jb next
			cmp cl,123
			jnb next
			
			;转大写
			and cl,11011111b
			mov ds:[si],cl
			
		next:	
			inc si
			jmp letterc_sta
			
	letterc_end:
			pop si
			pop cx
			ret
			
code ends

end start
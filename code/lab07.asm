assume cs:code,ds:data,ss:stack
 
data segment
  db '1975','1976','1977','1978','1979','1980','1981','1982','1983','1984'
  db '1985','1986','1987','1988','1989','1990','1991','1992','1993','1994','1995'
  dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
  dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
  dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
  dw 11542,14430,15257,17800
data ends
 
table segment
  db 21 dup ('year summ ne ?? ')
table ends

stack segment
	dw 0,0,0,0,0,0,0,0
stack ends

code segment

	start:	mov ax,data
			mov ds,ax
			mov bx,0
			
			mov ax,stack
			mov ss,ax
			mov sp,16
			
			mov ax,table
			mov es,ax
			mov bp,0
			;年份
			mov cx,21
		s0:	push cx
			mov cx,4
			mov si,0
			
		s1:	mov al,ds:[bx+si]
			mov es:[bp+si],al
			inc si
			loop s1
			
			pop cx
			add bx,4
			add bp,16
			loop s0
			
			;收入
			mov bp,5
			mov cx,21
		s2:	push cx
			mov cx,4
			mov si,0
			
		s3:	mov al,ds:[bx+si]
			mov es:[bp+si],al
			inc si
			loop s3
			
			pop cx
			add bx,4
			add bp,16
			loop s2
			
			;雇员
			mov bp,0ah
			mov cx,21
		s4:	push cx
			mov cx,2
			mov si,0
			
		s5:	mov al,ds:[bx+si]
			mov es:[bp+si],al
			inc si
			loop s5
			
			pop cx
			add bx,2
			add bp,16
			loop s4
			
			;人均收入
			mov bp,0
			mov cx,21
		s6:	
			mov ax,es:[bp+5]
			mov dx,es:[bp+7]
			div word ptr es:[bp+0ah]
			mov es:[bp+0dh],ax
			
			add bp,16
			loop s6
			
		mov ax,4c00h
		int 21h
code ends

end start
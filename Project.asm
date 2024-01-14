[org 0x100]
jmp start

oldisr:         dd  0
kbflag:         dw  2

rand:           dw 0
randnum:        dw 0

posBox:         dw  3920

tick:           dw 0, 40, 60, 80, 20

defaultSpeed:   dw  3,  2,  4,  5,  1
currentSpeed:   dw  0,  0,  0,  0,  0

rows:           dw  0,  0,  0,  0,  0

setAlpha:       db  0
alphaFlag:      db   0

missed:         dw  0
points:         db  0

pointsMessage:  db  'Points: ', 0
gameOverMessage:    db  'Game Over!', 0


cls:    push ax
        push es
        push di

    mov ax, 0xb800
    mov es, ax
    mov di, 0

    clear:  mov word [es : di], 0x0720
            add di, 2
            cmp di, 4000
            jnz clear

        pop di
        pop es
        pop ax
    ret

randG:
   push bp
   mov bp, sp
   pusha
   cmp word [rand], 0
   jne next

  MOV     AH, 00h    
  INT     1AH
  inc word [rand]
  mov     [randnum], dx
  jmp next1

  next:
  mov     ax, 25173          
  mul     word  [randnum]     
  add     ax, 13849          
  mov     [randnum], ax      

 next1:xor dx, dx
 mov ax, [randnum]
 mov cx, [bp+4]
 inc cx
 div cx
 
 mov [bp+6], dx
 popa
 pop bp
 ret 2

Print:
	push bp
	mov bp, sp
	push ax
	push es     
	push di

	mov ax, 0xb800
	mov es, ax

    mov ax, [cs : defaultSpeed]
    cmp word [cs : currentSpeed], ax
    jz print1

    mov ax, [cs : tick]
    sub ax, 160
    mov [cs : tick], ax

    mov ax, [cs : currentSpeed]
    inc ax
    
    mov [cs : currentSpeed], ax
    
    jmp speedOfChar2
print1:
    mov word [cs : currentSpeed], 0
	mov di, [cs : tick]
    push di

    sub di, 160
    mov word [es : di], 0x0720
    pop di

    mov ah, 0x07
    mov al, [cs : setAlpha]
    mov [es : di], ax
	
    cmp di, [cs : posBox]
    jnz print2

    mov ax, [points]
    inc ax
    mov [points], ax


speedOfChar2:
    mov ax, [cs : defaultSpeed + 2]
    cmp word [cs : currentSpeed + 2], ax
    jz print2

    mov ax, [cs : tick + 2]
    sub ax, 160
    mov [cs : tick + 2], ax

    mov ax, [cs : currentSpeed + 2]
    inc ax
    
    mov [cs : currentSpeed + 2], ax
    
    jmp speedOfChar3
print2:
    mov word [cs : currentSpeed + 2], 0
    mov di, [cs : tick + 2]
    push di


    sub di, 160
    mov word [es : di], 0x0720
    pop di

    mov ah, 0x07
    mov al, [cs : setAlpha]
    mov [es : di], ax
    
    cmp di, [cs : posBox]
    jnz print3

    mov ax, [points]
    inc ax
    mov [points], ax

    mov ax, 0
speedOfChar3:
    mov ax, [cs : defaultSpeed + 4]
    cmp word [cs : currentSpeed + 4], ax
    jz print3

    mov ax, [cs : tick + 4]
    sub ax, 160
    mov [cs : tick + 4], ax

    mov ax, [cs : currentSpeed + 4]
    inc ax
    
    mov [cs : currentSpeed + 4], ax
    
    jmp speedOfChar4
print3:
    mov word [cs : currentSpeed + 4], 0
    mov di, [cs : tick + 4]
    push di


    sub di, 160
    mov word [es : di], 0x0720
    pop di

    mov ah, 0x07
    mov al, [cs : setAlpha]
    mov [es : di], ax

    cmp di, [cs : posBox]
    jnz print4

    mov ax, [points]
    inc ax
    mov [points], ax

    mov ax, 0
speedOfChar4:
    mov ax, [cs : defaultSpeed + 6]
    cmp word [cs : currentSpeed + 6], ax
    jz print4

    mov ax, [cs : tick + 6]
    sub ax, 160
    mov [cs : tick + 6], ax

    mov ax, [cs : currentSpeed + 6]
    inc ax
    
    mov [cs : currentSpeed + 6], ax
    
    jmp speedOfChar5
print4:
    mov word [cs : currentSpeed + 6], 0
    mov di, [cs : tick + 6]
    push di


    sub di, 160
    mov word [es : di], 0x0720
    pop di

    mov ah, 0x07
    mov al, [cs : setAlpha]
    mov [es : di], ax


    cmp di, [cs : posBox]
    jnz print5

    mov ax, [points]
    inc ax
    mov [points], ax

    mov ax, 0
speedOfChar5:
    mov ax, [cs : defaultSpeed + 8]
    cmp word [cs : currentSpeed + 8], ax
    jz print5

    mov ax, [cs : tick + 8]
    sub ax, 160
    mov [cs : tick + 8], ax

    mov ax, [cs : currentSpeed + 8]
    inc ax
    
    mov [cs : currentSpeed + 8], ax
    
    jmp Points
print5:
    mov word [cs : currentSpeed + 8], 0
    mov di, [cs : tick + 8]
    push di


    sub di, 160
    mov word [es : di], 0x0720
    pop di

    mov ah, 0x07
    mov al, [cs : setAlpha]
    mov [es : di], ax


Points:
    cmp di, [cs : posBox]
    jnz skip
    
    mov ax, [points]
    inc ax
    mov [points], ax

skip:
	pop di
	pop es
	pop ax
	pop bp
	ret 2

printBox:   push ax
            push es
            push di

            
            mov di, [cs : posBox]
            mov ax, 0xb800
            mov es, ax
            mov word [es : di], 0x07DC
        
            mov al, [points]
            mov ah, 0x07
            add ax, 0x30
            mov [es:156],ax

            mov al, [missed]
            mov ah, 0x07
            add ax, 0x30
            mov [es:316],ax

            mov ax, [cs : kbflag]

            cmp ax, 0   ;LEFT
            jnz nextComp
            mov word [es : di], 0x0720
            sub di, 2
            cmp di, 3838
            jnz noWrap1
            mov di, 3998

noWrap1:    mov word [es : di], 0x07DC
            mov [cs : posBox], di
            ; mov word [cs:kbflag], 2

nextComp:   cmp ax, 1
            jnz skipComp
            mov word [es : di], 0x0720
            add di, 2
            cmp di, 4000
            jnz noWrap2
            mov di, 3840

noWrap2:    mov word [es : di], 0x07DC
            mov [cs : posBox], di
            ; mov word [cs:kbflag], 2


skipComp:
            pop di
            pop es
            pop ax
        ret


gameOver:   push ax
            push es
            push di

            call cls

            mov ax, 0xb800
            mov es, ax
            mov di, 1990

            mov si, gameOverMessage
            mov ah, 0x07
            mov cx, 10

            mov byte[es : 1990], 'G'
            mov byte[es : 1992], 'a'
            mov byte[es : 1994], 'm'
            mov byte[es : 1996], 'e'
            mov byte[es : 1998], ' '
            mov byte[es : 2000], 'O'
            mov byte[es : 2002], 'v'
            mov byte[es : 2004], 'e'
            mov byte[es : 2006], 'r'
            mov byte[es : 2008], '!'


            call clearBuffer

            pop di
            pop es
            pop ax
        jmp terminate



timer:  push ax

        mov ax, [missed]
        cmp ax, 10
        jnge noReset

        jmp gameOver


noReset:
        cmp word [cs : rows], 100
	    je Reset
	    inc word [cs : rows]
    	jmp Comp2

Reset:
        inc word [missed]

        mov byte [cs : alphaFlag], 0
	    mov word [cs : rows], 0

        sub sp, 2
        push 160
        call randG
        pop ax
     
        rcr ax, 1
        jnc evenNumber
     
        rcl ax, 1
        inc ax

evenNumber:
        rcl ax, 1

    	mov word [cs : tick], ax

        sub sp, 2
        push 160
        call randG
        pop ax
     
        rcr ax, 1
        jnc Comp2
     
        rcl ax, 1
        inc ax

Comp2:
        cmp word [cs : rows + 2], 50
        je Reset2
        inc word [cs : rows + 2]
        jmp Comp3

Reset2:
        inc word [missed]

        mov byte [cs : alphaFlag], 0
	    mov word [cs : rows + 2], 0

        sub sp, 2
        push 160
        call randG
        pop ax
     
        rcr ax, 1
        jnc evenNumber2
     
        rcl ax, 1
        inc ax

evenNumber2:
        rcl ax, 1
        
    	mov word [cs : tick + 2], ax

        sub sp, 2
        push 160
        call randG
        pop ax
     
        rcr ax, 1
        jnc Comp3
     
        rcl ax, 1
        inc ax

Comp3:
        cmp word [cs : rows + 4], 75
        je Reset3
        inc word [cs : rows + 4]
        jmp Comp4

Reset3:
        inc word [missed]

        mov byte [cs : alphaFlag], 0
	    mov word [cs : rows + 4], 0

        sub sp, 2
        push 160
        call randG
        pop ax
     
        rcr ax, 1
        jnc evenNumber3
     
        rcl ax, 1
        inc ax
evenNumber3:
        rcl ax, 1
    	mov word [cs : tick + 4], ax


        sub sp, 2
        push 160
        call randG
        pop ax
     
        rcr ax, 1
        jnc Comp4
     
        rcl ax, 1
        inc ax


Comp4:
        cmp word [cs : rows + 6], 75
        je Reset4
        inc word [cs : rows + 6]
        jmp Comp5

Reset4:
        inc word [missed]

        mov byte [cs : alphaFlag], 0
	    mov word [cs : rows + 6], 0

        sub sp, 2
        push 160
        call randG
        pop ax
     
        rcr ax, 1
        jnc evenNumber4
     
        rcl ax, 1
        inc ax

evenNumber4:
        rcl ax, 1
    	mov word [cs : tick + 6], ax


        sub sp, 2
        push 160
        call randG
        pop ax
     
        rcr ax, 1
        jnc Comp5
     
        rcl ax, 1
        inc ax


Comp5:
        cmp word [cs : rows + 8], 75
        je Reset5
        inc word [cs : rows + 8]
        jmp Doit

Reset5:
        inc word [missed]

        mov byte [cs : alphaFlag], 0
	    mov word [cs : rows + 8], 0

        sub sp, 2
        push 160
        call randG
        pop ax
     
        rcr ax, 1
        jnc evenNumber5
     
        rcl ax, 1
        inc ax
evenNumber5:
        rcl ax, 1
    	mov word [cs : tick + 8], ax


Doit:   add word [cs : tick], 160
        add word [cs : tick + 2], 160
        add word [cs : tick + 4], 160
        add word [cs : tick + 6], 160
        add word [cs : tick + 8], 160

	    push word [cs : tick]  

        cmp byte [cs : alphaFlag], 1
        jz skipSet
        sub sp, 2
        push 26
        call randG
        pop ax
        add ax, 65
        mov [cs : setAlpha], al
        mov byte [cs : alphaFlag], 1

skipSet:
        call Print
        call printBox

        mov al, 0x20
        out 0x20, al 
        pop ax  
    iret 

kbisr:
	push ax

	in al, 0x60
	cmp al, 0x4B
	jne NextCmp

	mov word [cs : kbflag], 0
    ; mov byte [es:0], 'L'
	je Exit

NextCmp:
	cmp al, 0x4D
	jne NoMatch

	mov word [cs : kbflag], 1 
    ; mov byte [es:0], 'R'
	je Exit

NoMatch:
	pop ax
	jmp far [cs : oldisr]

Exit:
	mov al, 0x20
	out 0x20, al
	pop ax
	iret

character:  push ax
            push es
            push di
    mov ax, 0xb800
    mov es, ax
    mov di, [posBox]
    mov word [es : di], 0x07DC

            pop di
            pop es
            pop ax
        ret

clearBuffer:    mov ax, 0x0c00
                int 0x21
            ret

start:  call cls
        call character


        mov di, [posBox]
        mov ax, 0
        mov es, ax

        mov ax, [es : 9*4]
        mov [oldisr], ax
        mov ax, [es : 9 * 4 + 2]
        mov [oldisr + 2], ax
        
        cli
        mov word [es : 9 * 4], kbisr
        mov [es : 9 * 4 + 2], cs
        mov word [es : 8 * 4], timer
        mov [es : 8 * 4 + 2], cs
        sti

terminate:   
		mov dx, start
        add dx, 15
		mov cl, 4
		shl dx, cl

		mov ax, 0x3100
		int 21h
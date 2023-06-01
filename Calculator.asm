include 'emu8086.inc'
.model small
.stack 100h 
.data
.Code
Calc proc
    Lable1:
    putc 0ah  
    putc 0dh
    print 'Enter your choice',0AH
    putc 0ah  
    putc 0dh
   
    print '1.Addition'
    putc 0ah  
    putc 0dh
    print '2.Subtraction' 
    putc 0ah  
    putc 0dh
    print '3.Multiplication'
    putc 0ah  
    putc 0dh
    print '4.Divide'
    putc 0ah  
    putc 0dh
    print '0.Close'
    putc 0ah  
    putc 0dh 
    mov ah,1
    int 21h
    cmp al,'1'
    je Addition
    cmp al,'2'
    je Subtraction
    cmp al,'3'
    je Multiplication
    cmp al,'4'
    je Divide
    cmp al,'0'
    je Close 
    jmp Wrong
    
    Addition:
    putc 0ah  
    putc 0dh
    print 'For Addition --> '
    putc 0ah
    putc 0dh
    print 'Enter Value 1: '
    mov ah,1
    int 21h
    mov bl,al
    putc 0ah  
    putc 0dh
    print 'Enter Value 2: '
    mov ah,1
    int 21h
    putc 0ah  
    putc 0dh
    print 'Result = '
    add al,bl
    mov dl,al
    sub dl,30h 
    mov ah,2
    int 21h
    jmp Lable1
    
    
    Subtraction:
    putc 0ah  
    putc 0dh
    print 'For Subtraction --> '
    putc 0ah
    putc 0dh
    print 'Enter Value 1: '
    mov ah,1
    int 21h
    add al,30h
    mov bl,al
    putc 0ah  
    putc 0dh
    print 'Enter Value 2: '
    mov ah,1
    int 21h 
    add al,30h
    putc 0ah  
    putc 0dh
    print 'Result = ' 
    sub bl,al
    mov dl,bl
    add dl,30h
    mov ah,2
    int 21h
    jmp Lable1
    
    
    Multiplication:
    putc 0ah  
    putc 0dh
    print 'For Multiplication --> '
    putc 0ah
    putc 0dh
    print 'Enter Value 1: '
    mov ah,1
    int 21h
    sub al,30h
    mov bl,al
    putc 0ah  
    putc 0dh
    print 'Enter Value 2: '
    mov ah,1
    int 21h
    sub al,30h
    putc 0ah  
    putc 0dh
    print 'Result = '
    mul bl
    mov bl,10
    div bl
    mov bl,ah
    mov dl,al
    add dl,30h
    mov ah,2 
    int 21h
    mov dl,bl
    add dl,30h
    mov ah,2 
    int 21h
    
    
    jmp Lable1

FormNo:     pop ax  
            push dx      
            mul bx
            pop dx
            add dx,ax
            mov ax,bx       
            mov bx,10
            push dx
            mul bx
            pop dx
            mov bx,ax
            dec cx
            cmp cx,0
            jne FormNo
            ret
  
  View:  mov ax,dx
       mov dx,0
       div cx 
       call ViewNo
       mov bx,dx 
       mov dx,0
       mov ax,cx 
       mov cx,10
       div cx
       mov dx,bx 
       mov cx,ax
       cmp ax,0
       jne View
       ret

  
 
 ViewNo:    push ax ;we will push ax and dx to the stack because we will change there values while viewing then we will pop them back from
           push dx ;the stack we will do these so, we don't affect their contents
           mov dx,ax ;we will mov the value to dx as interrupt 21h expect that the output is stored in it
           add dl,30h ;add 30 to its value to convert it back to ascii
           mov ah,2
           int 21h
           pop dx  
           pop ax
           ret
      
 
 
InputNo:    mov ah,0
            int 16h ;then we will use int 16h to read a key press     
            mov dx,0  
            mov bx,1 
            cmp al,0dh ;the keypress will be stored in al so, we will comapre to  0d which represent the enter key, to know wheter he finished entering the number or not 
            je FormNo ;if it's the enter key then this mean we already have our number stored in the stack, so we will return it back using FormNo
            sub ax,30h ;we will subtract 30 from the the value of ax to convert the value of key press from ascii to decimal
            call ViewNo ;then call ViewNo to view the key we pressed on the screen
            mov ah,0 ;we will mov 0 to ah before we push ax to the stack bec we only need the value in al
            push ax  ;push the contents of ax to the stack
            inc cx   ;we will add 1 to cx as this represent the counter for the number of digit
            jmp InputNo ;then we will jump back to input number to either take another number or press enter          
   
    
Divide:   
            putc 0ah  
    putc 0dh
            print 'Enter Value 1: '
            mov cx,0
            call InputNo
            push dx   
            putc 0ah  
    putc 0dh
            print 'Enter Value 2: ' 
            mov cx,0
            call InputNo
            pop bx
            mov ax,bx
            mov cx,dx
            mov dx,0
            mov bx,0
            div cx
            mov bx,dx
            mov dx,ax
            push bx 
            push dx 
            putc 0ah  
    putc 0dh
            print 'Result: '
            
            mov cx,10000
            pop dx
            call View
            pop bx
            cmp bx,0
            jmp Lable1
    
    Wrong:
    putc 0ah
    putc 0dh
    print 'Wrong Choice ...'
    putc 0ah
    putc 0dh
    jmp Lable1
    Close:
    putc 0ah
    putc 0dh
    Print 'Byeee' 
calc endp
cal proc    
    mov ah,1
    int 21h
    cal endp
main proc
    call calc
main endp
end main

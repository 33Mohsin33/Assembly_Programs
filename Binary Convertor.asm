include 'emu8086.inc'
.model small
.stack 100h
.data
arr db 7  dup('?')
.code
main proc 
    mov ax,@data
    mov ds,ax
    mov si,offset arr
    mov si,0
    print 'Enter Decimal Number : '
    mov ah,1
    int 21h
    sub al,30h
    mov bl,10
    mul bl
    mov bh,al
    
    mov ah,1
    int 21h
    sub al,30h
    add al,bh
     
    mov dh,al
    mov bl,2
    la1:
    mov ah,0 
    mov al,dh 
    div bl
    mov arr[si],ah
    inc si
    mov dh,al
    mov bh,ah    
    cmp dh,1
    jge la1   
    putc 0ah
    putc 0dh
    mov cx,si
    print 'In Binary : '
    lable:
    dec si      
    mov dl,arr[si] 
    mov ah,2
    add dl,30h
    int 21h
    loop lable
    exit:
    

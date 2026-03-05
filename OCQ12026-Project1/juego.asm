.data
x: .word 30
y: .word 35
.text
.global main

main:
    li $v0,100
    syscall
loop:
    
    li $v0,104
    syscall
    move $t0, $v0
    la $t1,x
    lw $t2,0($t1)
    la $t3,y	
    lw $t4,0($t3)	

    li $t5,1
    beq $t0,$t5,up
    li $t5,2
    beq $t0,$t5,down
    li $t5,3
    beq $t0,$t5,left
    li $t5,4
    beq $t0,$t5,right
    li $t5,5
    beq $t0,$t5,exit
    j mover
    
up:
    addi $t4, $t4, -1
    j mover
down:
    addi $t4, $t4, 1
    j mover
left:      
    addi $t2, $t2, -1
    j mover
right:
    addi $t2, $t2, 1
    j mover
exit:
    li $v0,105
    syscall
    li $v0,10
    syscall
    

mover:
    sw $t2,0($t1)
    sw $t4,0($t3)

    li $a0,0xFF0000
    li $v0,103
    syscall

    move $a0,$t2
    move $a1,$t4
    li $a2,10 ;width
    li $a3,30 ;height
    jal draw_rectangle

    li $a0,10       
    li $a1,200      
    li $a2,100       
    li $a3,0x00FF00 
    jal draw_horizontal_line


    li $v0,102
    syscall
    j loop

draw_rectangle:
    addi $sp,$sp,-8
    li $s0,0xFF0000
    sw $s0,0($sp) ;s0 es el color
    sw $ra,4($sp)
    move $t1,$zero ;y=0

loopy:
    slt $t2, $t1,$a3 ;si y<height
    beq $t2,$zero,done ;si no, termina
    move $t3,$zero ;x=0

loopx:
    slt $t4, $t3,$a2 ;si x<width
    beq $t4,$zero,sig ;si no, termina este ciclo y aumenta y
; ----------------------
    beq $t3,$zero,es_borde       ;si x=0, es borde izquierdo
    addi $t5,$a2,-1              ;desde 0 hasta width-1
    beq $t3,$t5,es_borde         ;si x=width-1, es borde derecho

    beq $t1,$zero,es_borde       ;y =0, borde superior
    addi $t5,$a3,-1              ;desde 0 hasta height-1
    beq $t1,$t5,es_borde         ;si y=height-1, borde inferior
    j skip_borde


es_borde:
    add $a0,$a0,$t3 ;a0=base+x 
    add $a1,$a1,$t1 ;a1=base+y
    lw $s0,0($sp);cargarelcolor
    li $v0,101
    syscall
    sub $a0, $a0, $t3    ;restaurar a0
    sub $a1, $a1, $t1    ;restaurar a1

skip_borde:
    addi $t3, $t3, 1 ;x++
    j loopx
;------------------------

sig:
    addi $t1, $t1, 1
    j loopy

done:
    lw $s0,0($sp)
    lw $ra,4($sp)
    addi $sp,$sp,8
    jr $ra

draw_horizontal_line:
;a0=x1, a1=x2, a2=y, a3=color

addi $sp,$sp,-20
sw $s0,0($sp) 
sw $s1,4($sp)
sw $s2,8($sp)
sw $s3,12($sp)
sw $ra,16($sp)


move $s0,$a0 ;x1
move $s1,$a1 ;x2
move $s2,$a2 ;y
move $s3,$a3 ;color
looph:
    slt $t1, $s0,$s1 ;si x<x2
    beq $t1,$zero,doneh ;si no, termina

    move $a0,$s0         
    move $a1,$s2         
    move $a2,$s3

    li   $v0,101
    syscall

    addi $s0, $s0, 1 ;x++
    j looph

    doneh:
    lw   $ra,16($sp)
    lw   $s0, 0($sp)
    lw   $s1, 4($sp)
    lw   $s2, 8($sp)
    lw   $s3, 12($sp)
    addi $sp,$sp,20
    jr   $ra



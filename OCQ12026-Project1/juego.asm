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

mover:
    sw $t2,0($t1)
    sw $t4,0($t3)

    li $a0,0x000000
    li $v0,103
    syscall

    move $a0,$t2
    move $a1,$t4
    li $a2,0x00FF00   
    li $v0,101
    syscall

    li $v0,102
    syscall
    j loop

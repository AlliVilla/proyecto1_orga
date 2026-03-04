.data

.text
.global main

main:
    li $v0,100
    syscall

    li $a0,30
    li $a1,35
    li $a2,0x00FF00
    li $v0,101
    syscall

    li $v0,102
    syscall
loop:
    j loop
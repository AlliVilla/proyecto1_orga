.data

.text
.global main

main:
    li $v0,100
    syscall

loop:
    j loop
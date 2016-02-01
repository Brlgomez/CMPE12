
.ent getDelay
.text
    la $a0, myStr
    jal puts
    la $a0, myStr2
    li $a1, 5
    jal printf
    nop
.global getDelay

getDelay:

    /* s0 contains the input */

    lw $s0, PORTD

    /*
        push into stack
        store word
        load address of hello world
        incremenet counter then print
        pop out of stack
    */

    push: addi $sp, $sp, -4
    sw $ra, 0($sp)

    la $a0, myStr
    jal puts
    nop

    move $a2, $zero
    addiu $s4, $s4, 1
    move $a1, $s4
    la $a0, myStr2
    nop
    jal printf
    
    pop: lw $ra, 0($sp)
    addi $sp, $sp, 4

    /*
       store PORT values into t
       and compare it to s0 then put
       sec values inside v0 
    */

    and $t0, $t0, 0
    addi $t0, $t0, 0x110
    beq $s0, $t0, doit1
    bne $s0, $t0, skip1
    doit1:
    addi $v0, $v0, 24000
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    skip1:
    addi $t0, $t0, 0x100
    beq $s0, $t0, doit2
    bne $s0, $t0, skip2
    doit2:
    addi $v0, $v0, 32000
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    skip2:
    addi $t0, $t0, 0x100
    beq $s0, $t0, doit3
    bne $s0, $t0, skip3
    doit3:
    addi $v0, $v0, 8000
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    skip3:
    addi $t0, $t0, 0x100
    beq $s0, $t0, doit4
    bne $s0, $t0, skip4
    doit4:
    addi $v0, $v0, 12000
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    skip4:
    addi $t0, $t0, 0x100
    beq $s0, $t0, doit5
    bne $s0, $t0, skip5
    doit5:
    addi $v0, $v0, 16000
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    skip5:
    addi $t0, $t0, 0x100
    beq $s0, $t0, doit6
    bne $s0, $t0, skip6
    doit6:
    addi $v0, $v0, 20000
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    skip6:
    addi $t0, $t0, 0x100
    beq $s0, $t0, doit7
    bne $s0, $t0, skip7
    doit7:
    addi $v0, $v0, 24000
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    skip7:
    addi $t0, $t0, 0x100
    beq $s0, $t0, doit8
    bne $s0, $t0, skip8
    doit8:
    addi $v0, $v0, 28000
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    skip8:
    addi $t0, $t0, 0x100
    beq $s0, $t0, doit9
    bne $s0, $t0, skip9
    doit9:
    addi $v0, $v0, 32000
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    skip9:
    addi $t0, $t0, 0x100
    beq $s0, $t0, doit10
    bne $s0, $t0, skip10
    doit10:
    addi $v0, $v0, 20000
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    skip10:
    addi $t0, $t0, 0x100
    beq $s0, $t0, doit11
    bne $s0, $t0, skip11
    doit11:
    addi $v0, $v0, 22000
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    skip11:
    addi $t0, $t0, 0x100
    beq $s0, $t0, doit12
    bne $s0, $t0, skip12
    doit12:
    addi $v0, $v0, 24000
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    skip12:
    addi $t0, $t0, 0x100
    beq $s0, $t0, doit13
    bne $s0, $t0, skip13
    doit13:
    addi $v0, $v0, 26000
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    skip13:
    addi $t0, $t0, 0x100
    beq $s0, $t0, doit14
    bne $s0, $t0, skip14
    doit14:
    addi $v0, $v0, 28000
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    skip14:
    addi $t0, $t0, 0x100
    beq $s0, $t0, doit15
    bne $s0, $t0, skip15
    doit15:
    addi $v0, $v0, 30000
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    skip15:
    addi $t0, $t0, 0x100
    beq $s0, $t0, doit16
    bne $s0, $t0, skip16
    doit16:
    addi $v0, $v0, 32000
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    add $v0, $v0, $v0
    skip16:

    jr $ra

.end getDelay
.data
    myStr: .asciiz ""
    myStr2: .asciiz "Hello, world! %d"

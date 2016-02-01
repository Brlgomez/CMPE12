
#include <WProgram.h>

/* define all global symbols here */
.global T1Setup
.global T1Stop
.global T1Start
.global milliseconds

.text
.set noreorder

/*********************************************************************
 * Start Timer 1
 ********************************************************************/
.ent T1Start
T1Start:
    /* s1 starts the timer */
    /* s2 clears the timer */
    /* s2 has priority */

    /* Set T1 ON actually turn on the timer */
    la $t0, T1CON
    li $t1, 0x8000 /* 15th bit */
    nop
    sw $t1, 8($t0)

    jr $ra
    nop

.end T1Start

/*********************************************************************
 * Stop Timer 1
 ********************************************************************/
.ent T1Stop
T1Stop:
     /* Set T1 ON actually turn on the timer */
    la $t0, T1CON
    li $t1, 0x8000 /* 15th bit */
    nop
    sw $t1, 4($t0)

    jr $ra
    nop

.end T1Stop


/*********************************************************************
 * Setup Timer 1 and interrupts (called it once)
 ********************************************************************/
.ent T1Setup
T1Setup:
    la $t0, TRISD
    li $t1, 0x0C00
    nop
    sw $t1, 8($t0)
    /* clear T1CON put in known state */
    la $t0, T1CON
    li $t1, 0xFFFF
    nop
    sw $t1, 4($t0)
    /* set T1CKPS set the prescalar */
    la $t0, T1CON
    li $t1, 0x0030
    nop
    sw $t1, 8($t0)
    /* clear TMR1 value clear the count if it was used */
    la $t0, TMR1
    li $t1, 0xFFFF
    nop
    sw $t1, 4($t0)
    /* set PR1 value set the period you want */
    la $t0, PR1
    li $t1, 781250
    nop
    sw $t1, 8($t0)
    /* set T1IP set the interrupt priority */
    la $t0, IPC1
    li $t1, 4
    nop
    sw $t1, 8($t0)
    /* clear T1IF clear the interrrupt priority */
    la $t0, IFS0
    li $t1, 0x0010
    nop
    sw $t1, 4($t0)
    /* Enable T1IE enable the interrupts */
    la $t0, IEC0
    li $t1, 0x10  /* 4th bit */
    nop
    sw $t1, 8($t0)
   
    jr $ra
    nop

.end T1Setup


/*********************************************************************
 * This is your ISR implementation. It is called from the vector table jump.
 ********************************************************************/
T1_ISR:

    push:
    addi $sp, $sp, -40
    sw $t0, 0($sp)
    sw $t1, 4($sp)

    lw $t0, PR1
    lw $t1, T1CON
    /*PR1 * 256 */
    mult $t0, $t1
    /* getting the least sign */
    mflo $t2
    lw $t3, frequency
    /* PR1 * 256 / frequency */
    div $t2, $t3
    /* get lower bits */
    mflo $t4
    /* add to milliseconds */
    lw $t0, milliseconds
    add $t0, $t0, $t4
    sw $t0, milliseconds

    /* clear TMR1 value clear the count if it was used */
    la $t0, TMR1
    li $t1, 0xFFFF
    nop
    sw $t1, 4($t0)
    /* clear T1IF clear the interrrupt priority */
    la $t0, IFS0
    li $t1, 0x0010
    nop
    sw $t1, 4($t0)

    pop:
    lw $t0, 0($sp)
    lw $t1, 4($sp)
    addi $sp, $sp, 40
    eret

    jr $ra
    nop

	
/*********************************************************************
 * This is the actual interrupt handler that gets installed
 * in the interrupt vector table. It jumps to the T1 timer
 * interrupt handler function.
 ********************************************************************/
.section .vector_4, code
	j T1_ISR
	nop


.data
milliseconds: .word 0
frequency: .word 1600000000

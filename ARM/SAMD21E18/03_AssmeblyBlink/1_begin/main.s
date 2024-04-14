.syntax unified
.cpu cortex-m0
.fpu softvfp 
.thumb  

.section .text.program_code

.equ portA_address, 0x41004400
.equ portA_DIRSET, 0x41004400+0x08
.equ portA_OUTTGL, 0x41004400+0x1C

.equ delayTime, 50000
.equ pinOffset, 10

.thumb_func
.global _start
_start:

	MOVS R4, #1
	LSLS R4, R4, #pinOffset  //R4 now contains the 1 at the pin offset bit. 

  LDR R5, =portA_DIRSET
  STR R4, [R5]

  LDR R5, =portA_OUTTGL

  loop:
    STR R4, [R5]
    LDR R3, =delayTime
    BL delay

  B loop

.thumb_func
delay:
	SUBS R3, R3, #1
	BNE delay
	BX LR
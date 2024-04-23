.syntax unified
.cpu cortex-m0
.fpu softvfp 
.thumb  

.section .text.program_code

.equ portA_address, 0x41004400
.equ portA_DIRSET, 0x41004400+0x08
.equ portA_OUTCLR, 0x41004400+0x14
.equ portA_OUTSET, 0x41004400+0x18
//.equ portA_OUTTGL, 0x41004400+0x1C
.equ portA_IN, 0x41004400+0x20
.equ portA_WRCONFIG, 0x41004400+0x28
.equ portA_PINCNFG, 0x41004400+0x40

.equ ledPinOffset, 10    //PA10
.equ switchPinOffset, 7  //PA07, 
//NOTE: a CLOSED switch will read LOW

//since pull a byte later, need the raw value to be a byte


.thumb_func
.global _start
_start:


  MOVS R3, #1
  LSLS R4, R3, #switchPinOffset //R4 is now switch mask (1 at switch pos)
  LSLS R3, #ledPinOffset  //R3 is now LED mask (1 at led pos)

  //The DIRSET should have one for every LED and 0 for everys switch.
  //The 0 is the default, but an explicit set will be safe. 

  LDR R5, =portA_DIRSET
  STR R3, [R5]   //move the 1s in for the LEDs

  @ OPTION 1: Set 1 pin
  @ MOVS R0, #switchPinOffset  //put switch # into R0 
  @ PUSH {R0-R3} // stash in stack
  @ BL setPullup
  @ POP {R0-R3}  // restore

  @ OPTION 2: Set multiple pins
  MOVS R0, R4  //put switch mask into R0
  PUSH {R0-R3} //stash in stack
  BL multiPinPullup
  POP {R0-R3}  //restore 

  LDR R5, =portA_OUTSET
  LDR R6, =portA_OUTCLR
  LDR R7, =portA_IN

    loop:
    //get the value of the IN register
    LDR R0, [R7]
				        //TST the reading against the mask. 
                //R0 should read 1 at switch location as default
                //due to pullup resistor so if the AND result
    TST R0, R4  //EQUALS 0 (no match), the switch is _closed_ 
    BEQ ledOn   //so jump to on

	ledOff:  //default path
    STR R3, [R6] //R3==ledMask, R6==portA_OUTCLR
    B loop

    ledOn:
    STR R3, [R5] //R3==ledMask, R5==portA_OUTSET
    B loop

//end _start


//Set R0 to contain the 32 pin mask of pins that should have pullups
.word multiPinPullup
.thumb_func
multiPinPullup:
  //Go ahead and set the ups
  LDR R1, =portA_OUTSET
  STR R0, [R1]

  MOVS R2, #1
  MOVS R3, #2
  RORS R2, R3  // Bit 30 -> 1 to enable PINCFG set
  MOVS R3, #6  // INEN 1 (bit 1) //set PULLEN 1 (bit 2)
  LSLS R3, #16 // move up to 3rd byte
  ORRS R3, R2  // Add bit 30 to R3

  LDR R2, =#0xFFFF
  TST  R0, R2
  BEQ  mpp_upperHalf
  MOVS R1, R0  // copy R0 for editing
  AND R1, R2   //isolate bottom half
  ORRS R1, R3  // update R1 with settings 
  LDR R2, =portA_WRCONFIG
  STR R1, [R2] // send WRCONFIG bottom half info

  mpp_upperHalf:
  LDR R1, =#0xFFFF0000
  TST R0, R1
  BEQ mpp_exit
  LSRS R0, #16 // isolate top half
  ORRS R0, R3  // add settings
  LSLS R1, #15 // make R1 0x80000000
  ORRS R0, R1  // Add top half flag in bit 31
  LDR R2, =portA_WRCONFIG //might be this value already. 
  STR R0, [R2] // send WRCONFIG top half info
  mpp_exit:
  BX LR  
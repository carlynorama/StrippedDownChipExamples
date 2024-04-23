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
.equ portA_PINCNFG, 0x41004400+0x40



.equ ledPinOffset, 10    //PA10
.equ switchPinOffset, 7  //PA07, 
//this value is NOT 7 because use LDR below
//which requires a word alignment
.equ switchPinCNFGOffset, portA_PINCNFG+0x04 
//NOTE: a CLOSED (true) switch will read LOW

.thumb_func
.global _start
_start:

	MOVS R3, #1
	LSLS R3, #ledPinOffset  //R3 is now LED mask (1 at led pos)
  MOVS R4, #1  
	LSLS R4, #switchPinOffset //R4 is now switch mask (1 at switch pos)

  //The DIRSET should have one for every LED and 0 for everys switch.
  //The 0 is the default, but an explicit set will be safe. 

  LDR R5, =portA_DIRSET
  STR R3, [R5]   //move the 1s in for the LEDs

setPullup:
  //---- For using internal pullup only
  LDR R5, =switchPinCNFGOffset //pinConfig closest word location
  LDR R0, [R5] //load current settings into R0
  MOVS R1, #6 //create value for INEN 1 (bit 1) //set PULLEN 1 (bit 2)
  LSLS R1, #24 //(8*(7-4)) //move it from 4 to 7
  ORRS R0, R1 //apply mask
  STR R0, [R5] //put the updated word back into the config.
  LDR R5, =portA_OUTSET
  STR R4, [R5] //set the out of the switch high
  //--- END setting internal pullup

  //if remove pullup code
  //set R5 to hold portA_OUTSET here
  LDR R6, =portA_OUTCLR
  LDR R7, =portA_IN

  loop:
    //get the value of the IN register
    LDR R0, [R7]

    //OPTION 1
    //Isolate the switch reading 
    ANDS R0, R4 //should typically be 1, due to pullup resistor
    MOVS R1, R0
    EORS R1, R4 //R1 will 1 at the switch bit iff the read was 0

    LSLS R0, #3  //move bit 7 (switch) to 10 (led)
    LSLS R1, #3  //move bit 7 (switch) to 10 (led)

    //Sending 0s the to set and clear registers has no effect.
    //The state of R0 always matches what should go to CLEAR
    //The state of R1 matches what should be in SET 
    STR R0, [R6]
    STR R1, [R5]
  B loop
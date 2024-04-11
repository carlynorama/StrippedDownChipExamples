.syntax unified
.cpu cortex-m0
.fpu softvfp 
.thumb  

.bss 
/* note, bss is marked noload in the linker */
/* no matter how long, shouldn't effect size of elf */
/* assembler wont let you store values that aren't 0 */
make: .word 0
something: .word 0
be: .word 0
here: .word 0

.data
/* like define, but tricksy. */
.equ pelargonium, 0x600dCA7
.equ rosebud, 0xF0CACC1A

/* variables with values */
ennie:  .word  124
meenie: .word  125
mineie: .word  126
moe:    .word  127

@ this is NOT how you create unallocated memory
@ these all point to the same place in memory. 
breakfast:  .word
lunch:      .word
dinner:     .word
midnight_snack: .word 27 

adr_ennie: .word ennie
adr_meenie: .word meenie
adr_mineie: .word mineie 
adr_moe: .word moe
adr_breakfast: .word breakfast
adr_lunch: .word lunch
adr_dinner: .word dinner
adr_midnight_snack: .word midnight_snack

adr_make: .word make

increment: .word 1

.section .text.program_code

.thumb_func
.word my_main
my_main:
  /* note to self main started finished */
  LDR  r7, =0x0000CCCC

  @ values of the unallocated should match
  @ ennie-moe after done with this. 
  LDR r0, =ennie
  ldmia r0!, {r1-r4}
  LDR r0, =make
  stmia r0!, {r1-r4}
  
  /* start with 0 */
  movs r0, #0
  loop_start:
    // Add 1 to register 'r0'.
    ADDS r0, r0, #1
  b loop_start

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

.section  .vectors
.global vector_table
vector_table:
    .word   _end_stack //edge of stack, set in linker
    .word   reset_handler   //reset handler
    .word   nmi_handler
    .word   hard_fault_handler
    .word   0//not in M0+
    .word   0//not in M0+
    .word   0//not in M0+
    .word   0//not in M0+
    .word   0//not in M0+
    .word   0//not in M0+
    .word   0//not in M0+
    .word   svc_handler
    .word   0//not in M0+
    .word   0//not in M0+
    .word   pendsv_handler
    .word   systick_handler

.text

.section .text.default_handler
.word default_handler
.thumb_func
default_handler:
   ldr r3, =#0x8BADF00D
   //hangs the program.
   b .

.weakref nmi_handler, default_handler
.weakref hard_fault_handler, default_handler
.weakref svc_handler, default_handler
.weakref pendsv_handler, default_handler
.weakref systick_handler, default_handler


.section .text.reset_handler
@ The Reset Handler 
.global reset_handler
.thumb_func
reset_handler:

  /* reset handler started */
  /* r7 will hold my notes to self  */
  ldr  r7, =0x0000AAAA
 
  /* set stack pointer */
  ldr  r1, =_end_stack
  mov  sp, r1

  /* set  .bss section to 0 (SRAM) */
   /* uses the jump to exit style loop */
  zero_bss:
    /* get 0 handy in two registers */
    movs r0, #0
    movs r1, #0
    /* get the bounds */
    ldr  r2, = _start_bss
    ldr  r3, = _end_bss
    loop_start_bss_zero:
      /* compare, first one is that there is a bss.  */
      cmp r2, r3
      /* compare: unsigned higher or same (is end higher than current )  */
      bhs loop_end_bss_zero
      /* will load 2 and increase the pointer after */
      @ stmia r2!, {r0,r1}
      stmia r2!, {r0} /* decided against moving bss to after data in linker  */
      b loop_start_bss_zero
    loop_end_bss_zero:

  /* copy .data section to SRAM */
  /* uses the jump to entry style loop */
  move_data_to_ram:
    /* get the bounds */
    ldr r0, = _start_data   
    ldr r1, = _end_data
    /* read head location */
    ldr r2, = _sidata
    b loop_enter_data_copy

    loop_action_data_copy:
      ldmia r2!, {r3}
      stmia r0!, {r3}
    loop_enter_data_copy:
      cmp r0, r1
      bcc loop_action_data_copy

  /* call the clock system initialization function.*/
  /* not done */

  /* call init of libraries (stdlib when loop in C) that need it.*/
  /* not done */

  /* note to self handler finished */
  LDR  r7, =0x0000BBBB

  /* Call the application's entry point.*/
  bl my_main             



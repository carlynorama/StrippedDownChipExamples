
.syntax unified
.cpu cortex-m0
.fpu softvfp 
.thumb  

.section  .vectors
.global vector_table
vector_table:
    .word   sp_initial_value //edge of stack, set in linker
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

.section .text.program_code
.thumb_func
.word my_main
my_main:
  loop_start:
    // Add 1 to register 'r0'.
    ADDS r0, r0, #1
  b loop_start
    

.section .text.reset_handler
@ The Reset Handler 
.global reset_handler
.thumb_func
reset_handler:
  LDR  r0, =sp_initial_value
  MOV  sp, r0

  LDR  r7, =0x000E6BDF
  MOVS r0, #0

  bl my_main             



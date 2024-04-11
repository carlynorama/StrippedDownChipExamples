// These instructions define attributes of our chip and
// the assembly language we'll use:
.syntax unified
.cpu cortex-m0
.fpu softvfp //The Cortex-M0 line has no floating-point hardware
.thumb  //name for the ARM Cortex-M instruction set
.text
//frequently written as isr_vector, that isn't the Microchip/Atmel convention
//No need for `+ 1` or `.align 1`, our compiler settings have it covered. 
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

  .weakref nmi_handler, default_handler
  .weakref hard_fault_handler, default_handler
  .weakref svc_handler, default_handler
  .weakref pendsv_handler, default_handler
  .weakref systick_handler, default_handler

.word default_handler
.thumb_func
default_handler:
   ldr r3, =#0x8BADF00D
   //hangs the program.
   b .

.global reset_handler
.thumb_func
reset_handler:
  LDR  r0, =sp_initial_value
  MOV  sp, r0

  LDR  r7, =0xF0CACC1A
  MOVS r0, #0
  main_loop:
    // Add 1 to register 'r0'.
    ADDS r0, r0, #1
    // Loop back.
    B    main_loop

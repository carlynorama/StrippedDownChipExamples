// These instructions define attributes of our chip and
// the assembly language we'll use:
.syntax unified
.cpu cortex-m0
.fpu softvfp //The Cortex-M0 line has no floating-point hardware
.thumb  //name for the ARM Cortex-M instruction set

// Global memory locations.
.global vector_table
.global on_reset

/*
 * interupt vector table
 * Only the RAM boundry and reset handler are
 * included, for simplicity.
 */
.type vector_table, %object
vector_table:
    .word _estack
    .word on_reset
.size vector_table, .-vector_table

/*
 * The Reset Handler. 
 */
.type on_reset, %function
on_reset:
  // Set the stack pointer to the end of the stack.
  // The '_estack' value is defined in the linker script.
  LDR  r0, =_estack
  MOV  sp, r0

  // Set some dummy values. When we see these values
  // in our debugger, we'll know that our program
  // is loaded on the chip and working.
  LDR  r7, =0xDEADBEEF
  MOVS r0, #0
  main_loop:
    // Add 1 to register 'r0'.
    ADDS r0, r0, #1
    // Loop back.
    B    main_loop
.size on_reset, .-on_reset
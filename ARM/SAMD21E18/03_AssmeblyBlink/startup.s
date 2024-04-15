.syntax unified
.cpu cortex-m0
.fpu softvfp 
.thumb  

.section  .vectors
.global vector_table
vector_table:
    //-------------- arm core list
    .word   _end_stack //edge of stack, set in linker
    .word   reset_handler //reset handler
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
    //-------------- peripherals list
    //SAMD21E18 doesn't do all available to the family.
    .word   PM_Handler
    .word   SYSCTRL_Handler
    .word   WDT_Handler
    .word   RTC_Handler
    .word   EIC_Handler
    .word   NVMCTRL_Handler
    .word   DMAC_Handler
    .word   USB_Handler
    .word   EVSYS_Handler
    .word   SERCOM0_Handler
    .word   SERCOM1_Handler
    .word   SERCOM2_Handler
    .word   SERCOM3_Handler
    .word   0/*SERCOM4_Handler*/
    .word   0/*SERCOM5_Handler*/
    .word   TCC0_Handler
    .word   TCC1_Handler
    .word   TCC2_Handler
    .word   TC3_Handler
    .word   TC4_Handler
    .word   TC5_Handler
    .word   0/*TC6_Handler*/
    .word   0/*TC7_Handler*/
    .word   ADC_Handler
    .word   AC_Handler
    .word   DAC_Handler
    .word   PTC_Handler
    .word   I2S_Handler
    .word   0/*AC1_Handler*/
    .word   0/*TCC3_Handler*/

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

.weakref PM_Handler, default_handler
.weakref SYSCTRL_Handler, default_handler
.weakref WDT_Handler, default_handler
.weakref RTC_Handler, default_handler
.weakref EIC_Handler, default_handler
.weakref NVMCTRL_Handler, default_handler
.weakref DMAC_Handler, default_handler
.weakref USB_Handler, default_handler
.weakref EVSYS_Handler, default_handler
.weakref SERCOM0_Handler, default_handler
.weakref SERCOM1_Handler, default_handler
.weakref SERCOM2_Handler, default_handler
.weakref SERCOM3_Handler, default_handler
//.weakref SERCOM4_Handler, default_handler
//.weakref SERCOM5_Handler, default_handler
.weakref TCC0_Handler, default_handler
.weakref TCC1_Handler, default_handler
.weakref TCC2_Handler, default_handler
.weakref TC3_Handler, default_handler
.weakref TC4_Handler, default_handler
.weakref TC5_Handler, default_handler
////.weakref TC6_Handler, default_handler
.weakref TC7_Handler, default_handler
.weakref ADC_Handler, default_handler
.weakref AC_Handler, default_handler
.weakref DAC_Handler, default_handler
.weakref PTC_Handler, default_handler
.weakref I2S_Handler, default_handler
.weakref AC1_Handler, default_handler
//.weakref TCC3_Handler, default_handler


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
  bl _start             



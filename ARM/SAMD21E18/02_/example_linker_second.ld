/* sets the entry point address */
/* first piece of code that executes after reset */
/* ENTRY(_symbol_name_) */
/* "Reset_Handler" in the .elf of many ARM sdks */
/* Syntax: ENTRY(_symbol_name_) */
ENTRY(on_reset)


MEMORY {
    /* Syntax: name(attr): ORIGIN = int, LENGTH = int */
    /* attr is kindof like chmod */

    /* get values from chip data sheet: SAMD21 section 10.2 */
    /* only need to mentions the one you'll use */

    /* also called CODE_MEMORY or ROM */
    /* NOT LEAVING ROOM FOR BOOTLOADER */
    flash(rx): ORIGIN = 0x00000000, LENGTH = 32k

    /* also called just RAM */
    sram(rwx): ORIGIN = 0x20000000, LENGTH = 4k
}

/* end of the stack  See 9.1 in Summary Data sheet */ 
/* Better be 0x20008000! */
_estack = ORIGIN(sram) + LENGTH(sram);    


/* Explains how memroy regions are subdivided */
/* tells linker how to merge inputs into output */
/* controls their order in elf */
/*  remember .text and .data from AVR?? */
SECTIONS {
    /* all the input files */ 
    /* not relocatable (vector table required to be at 0) */ 
    .text : 
    {
        /* merge all .isr_vector section*/
        /* all interupt vectors have to be at the start of flash. */
        /* some people put it in the top of text */
        /* some people put it before text */
        *(.vectors)

        /* merge all .text section*/
        /* .text of main.o, led.o etc. */
        *(.text) /* .text sections of all files. */

        /* merge all .rodata (read only data)*/
        *(.rodata)
        /* make sure value gets shifted to aligned data value. */
        /* Best practice to . */
        /* can leave out when you KNOW all your values */
        . = ALIGN(4);
        _etext = .; /* store location counter location into _etext*/
        /* location counter tracts vma not lma*/
    } > flash /* >(vma) AT (lma) are the same flash */ 

    /* relocatable. */
    .data : 
    {
        _sdata = .;
        *(.data)
        . = ALIGN(4);
        _edata = .;
    } > sram AT> flash

    /*Zero'd out space for declared but uninitialized variables */
    .bss {
        _sbss = .;
        *(.bss)
        *(COMMON) /*needed for SAMD21? */
        . = ALIGN(4);
        _ebss = .;
    } > sram

}



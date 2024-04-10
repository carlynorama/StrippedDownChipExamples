ENTRY(reset_handler);
MEMORY {
    flash(rx): ORIGIN = 0x00000000, LENGTH = 0x00040000 /*256K*/
    sram(rwx): ORIGIN = 0x20000000, LENGTH = 0x00008000 /*32K*/
}

/* sp_initial_value, _estack, __Top_of_Stack all the same. */
/* edge that stack grows away from.  */
/* better code would change this based on actual size of appilication */ 
/* this value is aligned 8 as required. */ 
_end_stack = ORIGIN(sram) + LENGTH(sram);  /* 0x20008000 */

SECTIONS {
    /* TODO: Coretex-M0+ have no vma???, impacts AT? */

    .text : { 
        /* The Top! */
        hello_startup.o(.vectors)  /* do the one from this file first */
        KEEP(*(.vectors .vectors.*)) /* do any in other files jic */
        /* . = 0xB4  /* HACK: could force the linker to jump expected end of vector table  */
        /* I want things realted to this code to come to the top */
        *(.text.reset_handler)
        *(.text.default_handler)
        /* the rest of the .text and .text sub sections */
        *(.text .text.*)
        /* all files read only data and read only data sub sections */
        *(.rodata, .rodata*) /* read only data */
       
    } > flash /* nothing relocatable */
    . = ALIGN(4);
    _end_text = .; /* store current location counter value in _end_text */

    /* Used by the startup to initialize data with the "originating" address */
    /* not so relevant on the M0+, more significant diff on beefier cores */
    _sidata = LOADADDR(.data);

    .data : { 
        . = ALIGN(4);
        _start_data = .; /* store current location in _end_data t*/
        *(.data) 
        . = ALIGN(4);
        _end_data = .; /* store current location in _end_data t*/
    } > sram AT> flash

    .bss(NOLOAD) : { 
        . = ALIGN(4);
        _start_bss = .;
        *(.bss) 
         *(COMMON) 
     } > sram
     /* todo, inside or outside */
     . = ALIGN(4);
     _end_bss = .;
}

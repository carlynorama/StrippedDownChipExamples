ENTRY(reset_handler);
MEMORY {
    flash(rx): ORIGIN = 0x00000000, LENGTH = 0x00040000 /*256K*/
    sram(rwx): ORIGIN = 0x20000000, LENGTH = 0x00008000 /*32K*/
}
sp_initial_value = ORIGIN(sram) + LENGTH(sram);  /* 0x20008000 */

SECTIONS {

    .text   : { 
        hello_main.o(.vectors ) 
        *(.vectors)
        *(.text.reset_handler)
        *(.text.default_handler)
        *(.text) 
    } > flash
    .data : { *(.data) } > sram AT> flash
    /*https://home.cs.colorado.edu/~main/cs1300/doc/gnu/ld_3.html#SEC8*/
    .bss    : { *(.bss)  *(COMMON)  } > sram
}

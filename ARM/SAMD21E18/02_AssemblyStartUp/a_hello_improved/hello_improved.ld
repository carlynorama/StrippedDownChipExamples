ENTRY(reset_handler);
MEMORY {
    flash(rx): ORIGIN = 0x00000000, LENGTH = 0x00040000 /*256K*/
    sram(rwx): ORIGIN = 0x20000000, LENGTH = 0x00008000 /*32K*/
}
sp_initial_value = ORIGIN(sram) + LENGTH(sram);  /* 0x20008000 */

SECTIONS {
    .text   : {  *(.text)  } > flash
    .rodata : { *(.rodata) } > sram AT> flash
    .bss    : { *(.bss)    } > sram
}

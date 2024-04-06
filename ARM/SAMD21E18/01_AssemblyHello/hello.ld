
MEMORY {
    /* Syntax: name(attr): ORIGIN = int, LENGTH = int */
    /* attr is kindof like chmod */

    /* get values from chip data sheet: SAMD21 section 10.2 */
    /* only need to mentions the one you'll use */

    /* also called CODE_MEMORY or ROM */
    /* NOT LEAVING ROOM FOR BOOTLOADER */
    flash(rx): ORIGIN = 0x00000000, LENGTH = 0x00040000 /*256K*/

    /* also called just RAM */
    sram(rwx): ORIGIN = 0x20000000, LENGTH = 0x00008000 /*32K*/
}

/* end of the stack  See 9.1 in Summary Data sheet */ 
_estack     = ORIGIN(sram) + LENGTH(sram);    /* stack points to end of SRAM */



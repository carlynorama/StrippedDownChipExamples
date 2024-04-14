
The SAM D21 implements the ARM® Cortex®-M0+ processor, based on the ARMv6 Architecture and Thumb®-2 ISA. The Cortex M0+ is 100% instruction set compatible with its predecessor, the Cortex-M0 core, and upward compatible to Cortex-M3 and M4 cores. The ARM Cortex-M0+ implemented is revision r0p1. For more information refer to www.arm.com.

[dsheet]:https://ww1.microchip.com/downloads/aemDocuments/documents/MCU32/ProductDocuments/DataSheets/SAM-D21-DA1-Family-Data-Sheet-DS40001882H.pdf
[trm]:https://developer.arm.com/documentation/ddi0484/latest/
[arch]:https://documentation-service.arm.com/static/5f8ff05ef86e16515cdbf826
[errata]:(https://ww1.microchip.com/downloads/en/DeviceDoc/SAM-D21DA1-Family-Silicon-Errata-and-Data-Sheet-Clarification-DS80000760G.pdf)

- Most Important Link For Vector Table. Do. Not. Skip.
    - https://developerhelp.microchip.com/xwiki/bin/view/products/mcu-mpu/32bit-mcu/sam/samd21-mcu-overview/samd21-processor-overview/samd21-nvic-overview/
- Product Reference Page
    - https://www.microchip.com/en-us/product/ATSAMD21E18
    - Reachable from here:
        - arm-gcc compiler tools, (come with [Atmel Studio](https://www.microchip.com/en-us/tools-resources/develop/microchip-studio) if you have that) https://www.microchip.com/en-us/tools-resources/develop/microchip-studio/gcc-compilers
        - http://packs.download.atmel.com/ (rename .atpack files to .zip) ([packs on github](https://github.com/Microchip-MPLAB-Harmony/dev_packs/tree/master/Microchip))
        - https://www.keil.arm.com/devices/ for CMSIS? Link provided by Microchip. hunh.
- Full Family Data Sheet
    - https://ww1.microchip.com/downloads/aemDocuments/documents/MCU32/ProductDocuments/DataSheets/SAM-D21-DA1-Family-Data-Sheet-DS40001882H.pdf
- Errata
    - https://ww1.microchip.com/downloads/en/DeviceDoc/SAM-D21DA1-Family-Silicon-Errata-and-Data-Sheet-Clarification-DS80000760G.pdf
- - Cortex-M0+ Technical Reference Manual (Revision: r0p1) 
    - https://developer.arm.com/documentation/ddi0484/c/?lang=en
- Cortex-M0+ Generic Users Guide
    - https://developer.arm.com/documentation/dui0662/b?lang=en
- ARMv6-M Architecture Reference Manual
    - PDF https://documentation-service.arm.com/static/5f8ff05ef86e16515cdbf826
    - Online Viewer https://developer.arm.com/documentation/ddi0419/latest/
- Demo project repo, [SAMD21N Getting Started](https://github.com/Microchip-MPLAB-Harmony/reference_apps/blob/143e5438a43c50660b893980bcb41b930dcf9821/apps/sam_d21_cnano/samd21n_getting_started/). Needs MPLAB software to run, uses C, but I wanted to look at the list of [hardware defs](https://github.com/Microchip-MPLAB-Harmony/reference_apps/tree/143e5438a43c50660b893980bcb41b930dcf9821/apps/sam_d21_cnano/samd21n_getting_started/firmware/src/config/sam_d21_cnano) and [linker scripts](https://github.com/Microchip-MPLAB-Harmony/reference_apps/blob/143e5438a43c50660b893980bcb41b930dcf9821/apps/sam_d21_cnano/samd21n_getting_started/firmware/src/config/sam_d21_cnano/ATSAMD21G17D.ld) to double check my work. 
    - https://github.com/Microchip-MPLAB-Harmony/reference_apps/tree/143e5438a43c50660b893980bcb41b930dcf9821/apps/sam_d21_cnano/samd21n_getting_started/firmware/src/packs
- https://github.com/Microchip-MPLAB-Harmony/dev_packs/tree/345dc12d42a4fdec72117b64a8c3527023bdeca9/Microchip/SAMD21_DFP/3.6.144/samd21a/armcc/armcc



pg 31 DS40001882H-page

1. Use the SAMD21J pinout muxing for WLCSP45 package.
2. All analog pin functions are on peripheral function B. Peripheral function B must be selected to disable the digital control of the pin.
3. Only some pins can be used in SERCOM I2C mode. Refer to 7.2.3 SERCOM I2C Pins.
4. TC6 and TC7 are not supported on the SAM D21E. Refer to 2. Configuration Summary for details.
5. This function is only activated in the presence of a debugger.
6. If the PA24 and PA25 pins are not connected, it is recommended to enable a pull-up on PA24 and PA25
through input GPIO mode. The aim is to avoid an eventually extract power consumption (<1mA) due to a not stable level on pad. The port PA24 and PA25 doesn't have Drive Strength option.
7. SERCOM4 and SERCOM5 are not supported in SAMD21ExxA, SAMD21E15(B/BU/CU/L), SAMD21E16(B/BU/CU/L) and SAMD21E17(D/DU/L). Refer to the 2. Configuration Summary for details.
8. TCC3 is only supported in SAMD21x17D. Refer to the 2. Configuration Summary for details.


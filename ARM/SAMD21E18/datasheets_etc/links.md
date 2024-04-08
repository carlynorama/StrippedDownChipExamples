
[dsheet]:https://ww1.microchip.com/downloads/aemDocuments/documents/MCU32/ProductDocuments/DataSheets/SAM-D21-DA1-Family-Data-Sheet-DS40001882H.pdf
[trm]:https://developer.arm.com/documentation/ddi0484/latest/
[arch]:https://documentation-service.arm.com/static/5f8ff05ef86e16515cdbf826

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
- Cortex-M0 Technical Reference Manual (Revision: r0p0) 
    - PDF https://documentation-service.arm.com/static/5e8e294afd977155116a6a5b  
    - Online Viewer https://developer.arm.com/documentation/ddi0484/latest/
- ARMv6-M Architecture Reference Manual
    - PDF https://documentation-service.arm.com/static/5f8ff05ef86e16515cdbf826
    - Online Viewer https://developer.arm.com/documentation/ddi0419/latest/
- Demo project repo, [SAMD21N Getting Started](https://github.com/Microchip-MPLAB-Harmony/reference_apps/blob/143e5438a43c50660b893980bcb41b930dcf9821/apps/sam_d21_cnano/samd21n_getting_started/). Needs MPLAB software to run, uses C, but I wanted to look at the list of [hardware defs](https://github.com/Microchip-MPLAB-Harmony/reference_apps/tree/143e5438a43c50660b893980bcb41b930dcf9821/apps/sam_d21_cnano/samd21n_getting_started/firmware/src/config/sam_d21_cnano) and [linker scripts](https://github.com/Microchip-MPLAB-Harmony/reference_apps/blob/143e5438a43c50660b893980bcb41b930dcf9821/apps/sam_d21_cnano/samd21n_getting_started/firmware/src/config/sam_d21_cnano/ATSAMD21G17D.ld) to double check my work. 
    - https://github.com/Microchip-MPLAB-Harmony/reference_apps/tree/143e5438a43c50660b893980bcb41b930dcf9821/apps/sam_d21_cnano/samd21n_getting_started/firmware/src/packs
- https://github.com/Microchip-MPLAB-Harmony/dev_packs/tree/345dc12d42a4fdec72117b64a8c3527023bdeca9/Microchip/SAMD21_DFP/3.6.144/samd21a/armcc/armcc

### How to search github

When looking for start up code to verify my work wasn't totally off base, github searches of: 
- `SAMD21E18 path:*.s`
- `path:*SAMD21* path:*.s` 
- `path:*SAMD21* path:*.s path:*startup*`
- `#ifndef _SAMD21E18A_`

Turned up some of the most useful results. 

To go a little more scatter shot, the following phrases (plus your Microchip part number) are an indicator that file started from the official source. I'm sure you can come up with more "Statistically Improbable Phrases" from the demo projects, etc above. 
    - "\brief Header file for"
    - "Microchip Technology Inc. and its subsidiaries"
    - "Copyright (wild card) Atmel Corporation"
    - "\brief This module contains"
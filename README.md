# Stripped Down Chip Examples

What would it take to replace C in embedded computing? That's a question both Rust and Swift have started to ask.

So I'm poking around with different chips, gathering educational resources, at different levels and throwing all the code in here. The goal is for each folder to be self-contained, have a supporting post. 

## AVR

### ATTiny44 (Breadboard)

https://www.whynotestflight.com/excuses/hello-led-on-an-avr-attiny45-in-c/

One folder with both a blink example and using a switch to control an LED example in one page of C each.  Relies heavily on avr-gcc doing its thing. Avrdude as programming software. Highly recommend [this YouTube series](https://www.youtube.com/playlist?list=PLNyfXcjhOAwOF-7S-ZoW2wuQ6Y-4hfjMR), as the post assumes you already know what it's covered. 

## ARM

Arm chips are so easy with their drag and drop UF2 programming. I honestly never bothered to try to go around that. Whelp.

### Coretex-M0+ - SAMD21E18 (Teensy with soldered leads)

arm-gcc, OpenOCD, GDB, Jlink

#### 01_AssemblyHello (no bootloader)

- https://www.whynotestflight.com/excuses/how-can-i-make-programming-an-arm-chip-as-hard-as-possible/

Proof that the tool chain works. Minimum code + linker file to twiddle registers. Required GDB to work to see anything. 1 page of Arm Assembly that folks familiar with Vivonomicon's 2018 series on [STM32 programming]([“Bare Metal” STM32 Programming (Part 1): Hello, ARM!](https://vivonomicon.com/2018/04/02/bare-metal-stm32-programming-part-1-hello-arm/)) will find familiar! Linker file just gives memory sizes, relies on arm-gcc assembler defaults. 


#### 02_AssemblyStartup (no bootloader)

- 

Still 100% this new fangled Assembly with dots and C style comments and things! Warning - I need to find a linter. Went to a thumb-only compliant syntax that doesn't require the .type macros to see the difference.  2 Folders 
    
    - one with a single page script and linker file with minimal SECTION. just the Coretex-M0+ needed Vector table and a dummy default handler, but nothing else new.

    - works from previous folder into a 2 page setup with a startup.s and main.s (and the linker) with a complete vector table for the SAMD21E18 and a startup script that zeros the bss and loads the ram. Lots of variables in main.s to test that it worked. 




## Official Documentation for Toolchain Used

- https://sourceware.org/binutils/docs/
    - Assembler https://sourceware.org/binutils/docs/as/
    - Linker https://sourceware.org/binutils/docs/ld/index.html
- https://gcc.gnu.org
    - https://gcc.gnu.org/wiki/avr-gcc
    - https://developer.arm.com/Tools%20and%20Software/GNU%20Toolchain
- https://www.gnu.org/software/make/
    - https://www.gnu.org/software/make/manual/make.html#Implicit-Variables
    - to save a doc of all implicit in specific environment, in a dir with no make files run ‘make -p > make_implicit.txt’
- https://sourceware.org/gdb/
- https://openocd.org/pages/documentation.html
- https://avrdudes.github.io/avrdude/7.3/avrdude.html



## How to search github for more code like this

When looking for code to related to embedded projects using the path feature with the part number, file type and common file name fragment can really help: 

- `SAMD21E18 path:*.s`
- `path:*SAMD21* path:*.s` 
- `path:*SAMD21* path:*.s path:*startup*`

Certain code fragments are so specific they target exactly what you need: 

- `#ifndef _SAMD21E18A_`

To go a little more scatter shot, some companies and organization have "Statistically Improbable Phrases" in their demo projects and headers that make it easier to find derivative works or projects that use those libraries. Some examples for Microchip/Atmel:

    - "\brief Header file for"
    - "Microchip Technology Inc. and its subsidiaries"
    - "\brief This module contains"


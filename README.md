# Stripped Down Chip Examples


More documentation on its way, but in the mean time: 

- https://www.whynotestflight.com/excuses/hello-led-on-an-avr-attiny45-in-c/
- https://www.whynotestflight.com/excuses/how-can-i-make-programming-an-arm-chip-as-hard-as-possible/


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


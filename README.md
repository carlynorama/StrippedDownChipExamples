# Stripped Down Chip Examples


More documentation on its way, but in the mean time: 

- https://www.whynotestflight.com/excuses/hello-led-on-an-avr-attiny45-in-c/
- https://www.whynotestflight.com/excuses/how-can-i-make-programming-an-arm-chip-as-hard-as-possible/




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
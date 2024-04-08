


- https://www.whynotestflight.com/excuses/how-can-i-make-programming-an-arm-chip-as-hard-as-possible/

assembler/compiler/linker: 
arm-gcc 
installed from https://developer.arm.com/Tools%20and%20Software/GNU%20Toolchain via
```
brew install --cask gcc-arm-embedded
```

programmer: 
jlink edu / openocd

debugger: 
openocd

```bash
#to run blink, the default
make 

#to run switch_control
make TARGET=switch_control
```

Note: No assembly version or linker file/start up script for the AVR example for now.  avr-gcc does SO MUCH. TODO. 
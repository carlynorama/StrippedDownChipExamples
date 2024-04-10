


- https://www.whynotestflight.com/excuses/how-can-i-make-programming-an-arm-chip-as-hard-as-possible/

assembler/compiler/linker: 
arm-gcc 
installed from https://developer.arm.com/Tools%20and%20Software/GNU%20Toolchain via
```bash
# brew install --cask gcc-arm-embedded
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

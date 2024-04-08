


- https://www.whynotestflight.com/excuses/hello-led-on-an-avr-attiny45-in-c/

assembler/compiler/linker: avr-gcc 
programmer: avr-dude 
debugger: N/A

```bash
#to run blink, the default
make 

#to run switch_control
make TARGET=switch_control
```

Note: No assembly version or linker file/start up script for the AVR example for now.  avr-gcc does SO MUCH. TODO. 
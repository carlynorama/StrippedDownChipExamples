



## What's in this folder

I wanted to go from one of those hyper minimal examples to a medium-minimal version.


### a_hello_improved 

adds a minimal vector table (Just the Cortex-M0+ needed entries) and a minimal SECTIONS command to the linker file. 

### b_hello_main
 
Works its way up splitting out the program code into its own section then into its own file. Also fleshes out the reset handler code. Still thumb-cores only syntax. 

- single file with the "main loop" moved up to the top of the file (but not the entry point)

- single file with a startup function that actually moves the data and clears the bss

- program code and startup code no longer share a file. Vector table lists ALL the SAMD21E18 peripherals and provides default handlers that can be overridden (un tested). (TODO, the makefile needs some love.) 


## Running without the makefile(s)

Handy direct commands for debugging before switching to makefile.

Set the shell instance's target. (The included make files will use this variable, too.) 

```zsh
export TARGET="hello_improved"
env # to check
```



```zsh
arm-none-eabi-as -v -g -c -Wall -mcpu=cortex-m0 -mthumb -o $TARGET.o $TARGET.s
arm-none-eabi-objdump --disassemble $TARGET.o
arm-none-eabi-objdump --syms $TARGET.o
#linker stand alone doesn't handle thumb->elf? TODO
#arm-none-eabi-ld -g -v -lc -Wall -mcpu=cortex-m0 -mthumb --specs=nosys.specs -nostdlib -lgcc -T./$TARGET.ld -o $TARGET.elf $TARGET.o
#arm-none-eabi-ld -g -v -lc -Wall -mcpu=cortex-m0 -mthumb --specs=nosys.specs -nostdlib -lgcc -T./$TARGET.ld -o $TARGET.elf $TARGET.o
arm-none-eabi-gcc -mcpu=cortex-m0 -mthumb -g --specs=nosys.specs -nostdlib -lgcc -T./$TARGET.ld -o $TARGET.elf $TARGET.o
#arm-none-eabi-gcc -Wall -lgc -mcpu=cortex-m0 -mthumb --specs=nosys.specs -nostdlib  $TARGET.o -T./$TARGET.ld -o $TARGET.elf

arm-none-eabi-objdump --disassemble $TARGET.elf
arm-none-eabi-nm $TARGET.elf
arm-none-eabi-nm --numeric-sort $TARGET.elf
arm-none-eabi-objcopy -O binary $TARGET.elf $TARGET.bin

arm-none-eabi-gcc -g -Wall -nostdlib -T./$TARGET.ld *.o -o combined.elf

```



## Debugging


```bash
cd $YOUR_PROJECT_FOLDER
arm-none-eabi-gdb $TARGET.elf -iex "target extended-remote localhost:3333"
```

for debugging hello and hello derivatives. 

```zsh
## Optional Layout Changes
(gdb) layout asm
(gdb) layout regs  
## ^x o to switch between
## ^x a to close

(gdb) layout reg
(gdb) info registers
(gdb) info register r0
(gdb) info register r7  ##wont be the message yet
(gdb) info break
(gdb) break main_loop
(gdb) info break
(gdb) continue # ^c to escape
(gdb) info register r0
(gdb) info register r7
(gdb) continue # ^c to escape
(gdb) info register r0
(gdb) stepi
(gdb) info register r0
# etc...
```

Where 0x2000000 is the start of the memory location you'd like to get 10 values after.
```zsh
(gdb) x/10x 0x20000000
```

for checking startup routine v1 ()

```zsh
(gdb) layout reg
## optional if want to watch it step through
## can also break on one of the loop boundaries
# or just stepi through
(gdb) break zero_bss
(gdb) break move_data_to_ram

(gdb) break my_main
    #stepi
    #when r0 is ennie and make address note them so you can check
    x/10x 0xMAKE_ADDRESS
(gdb) break loop_start
```
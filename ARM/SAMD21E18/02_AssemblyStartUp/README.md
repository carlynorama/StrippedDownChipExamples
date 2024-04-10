



## What's in this folder

I wanted to go from one of those hyper minimal examples to a more "adult" version.

That took a lot of steps.

### a_hello_improved 

adds a minimal vector table (Just the Cortex-M0+ needed entries) and a minimal SECTIONS command to the linker file. 

### b_hello_main
 
 works it way up splitting out the program code into its own section then into its own file. Also fleshes out the reset handler code. Still thumb-cores only syntax. 

### c_hello_main_full 

fills out the whole vector table with all perifiperals. Switches the syntax to use macros so it's more reusable with other Cortex-M processors that don't use thumb mode. 


## Running without without the make file(s)

Sometimes the code isn't ready for the default make file...

Set the shell instance's target. (The included make files will use this variable, too.) 

```zsh
export TARGET="hello_improved"
env # to check
```

handy direct commands for debugging before switching to make file

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

arm-none-eabi-gcc -nostdlib -T./$TARGET.ld *.o -o combined.elf

```

arm-none-eabi-gcc -g -Wall -nostdlib -T./$TARGET.ld *.o -o combined.elf

debugging

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
```
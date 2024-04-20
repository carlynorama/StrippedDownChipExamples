

## Debugging

```zsh
export TARGET="combined"
env # to check
```

```bash
cd $YOUR_PROJECT_FOLDER
arm-none-eabi-gdb combined.elf -iex "target extended-remote localhost:3333"
```

for debugging hello and hello derivatives. 

```zsh
## Optional Layout Changes
(gdb) layout reg
## ^x o to switch between
## ^x a to close

(gdb) break _start
(gdb) break loop
(gdb) info break
(gdb) stepi
(gdb) stepi  #as needed
(gdb) continue # ^c to escape
(gdb) disable  #to turn off breakpoints
# etc...
```
Where 0x41004400 is the start of PORTA
```zsh
(gdb) x/1x 0x41004400 #for the direction set
(gdb) x/1x 0x41004410 #for the current output values
(gdb) x/1x 0x41004444 #for the PINCFG settings, PA07 is top byte
```

x/10x 0x41004410
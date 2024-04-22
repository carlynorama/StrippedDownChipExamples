

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
(gdb) x/1x 0x41004444 #PINCNFG subset (PA07 in top byte)
```


arm-none-eabi-gcc --target-help -mcpu=nonsense
//https://stackoverflow.com/questions/53156919/what-are-my-available-march-mtune-options


https://sourceware.org/gdb/current/onlinedocs/gdb.html/Command-Files.html

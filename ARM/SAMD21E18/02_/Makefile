###############################################################################
# Makefile for a simple SAMD21 Assembly project
###############################################################################

## General Flags
TARGET ?= hello#set if not defined 
LINKER_FILE ?= $(TARGET).ld
MACH = cortex-m0

TOOL_BASE = arm-none-eabi-
CC = $(TOOL_BASE)gcc
OBJCOPY = $(TOOL_BASE)objcopy
OBJDUMP = $(TOOL_BASE)objdump
GDB = $(TOOL_BASE)gdb
AS = $(TOOL_BASE)as
LD = $(TOOL_BASE)ld


## Options common to compile, link and assembly rules
COMMON = -mcpu=$(MACH)
COMMON += -mthumb

## Compile options common for all C compilation units.
CFLAGS = $(COMMON)
CFLAGS += -Wall
CFLAGS += -g
CFLAGS += -Os

# for when using AVR LibC // i.e. #if F_CPU == 500000 type code
#Flags that start with -D are a define 
#equivalent to #define F_CPU = the variable value
#CFLAGS += -DF_CPU=$(F_CPU) #creates the F_CPU var for the compiler. 

## Linker flags
LDFLAGS = $(COMMON)
#LDFLAGS +=  -Wl,-Map=$(TARGET).map
LDFLAGS += --specs=nosys.specs -nostdlib -lgcc



## Objects that must be built in order to link
OBJECTS = $(TARGET).o 

## Objects explicitly added by the user
LINKONLYOBJECTS = 

# Programming support using avrdude. Settings and variables.
PROGRAMMER = openocd
PROGRAMMER_FLAGS = -f 

## Build
all: $(TARGET).elf

## Compile
%.o : %.S
	$(CC) -x assembler-with-cpp -c $(CFLAGS) $<

##Link
%.elf: $(OBJECTS)
	 $(CC) $(LDFLAGS) $(OBJECTS) $(LINKONLYOBJECTS)  -T./$(LINKER_FILE) -o $(TARGET).elf

# %.hex: $(TARGET).elf
# 	avr-objcopy -O ihex $(HEX_FLASH_FLAGS)  $< $@

# %.lss: $(TARGET).elf
# 	avr-objdump -h -S $< > $@

# size: ${TARGET}.elf
# 	@echo
# 	@avr-size -C --mcu=${MCU} ${TARGET}.elf

#erase:
	

# Program the device.  
program: $(TARGET).hex
	$(PROGRAMMER) $(AVRDUDE_FLAGS) $(AVRDUDE_WRITE_FLASH)

## Clean target
#.PHONY: clean
clean:
	-rm -rf $(OBJECTS) $(TARGET).elf $(TARGET).hex $(TARGET).lss $(TARGET).map 


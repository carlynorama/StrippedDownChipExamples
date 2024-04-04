###############################################################################
# Makefile for a simple ATtiny project
###############################################################################

## General Flags
TARGET ?= blink #set if not defined 
MCU = attiny45

# for when using AVR LibC
#F_CPU = 16000000   # 16MHz on Arduino board
#F_CPU = 8000000    # internal osc
#F_CPU = 1000000    # internal osc w/ clkdiv8
#F_CPU  =  500000   # internal osc w/ clkdiv16
#F_CPU =  250000    # internal osc w/ clkdiv32

# Theses values are currently the defaults. 
LFUSE=0x62
HFUSE=0xDF
EFUSE=0xFF

CC = avr-gcc
CPP = avr-g++

## Options common to compile, link and assembly rules
COMMON = -mmcu=$(MCU)

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
LDFLAGS +=  -Wl,-Map=$(TARGET).map

## Objects that must be built in order to link
OBJECTS = $(TARGET).o 

## Intel Hex file production flags
HEX_FLASH_FLAGS = -j.text -j.data 

## Objects explicitly added by the user
LINKONLYOBJECTS = 

# Programming support using avrdude. Settings and variables.
AVRDUDE = avrdude
AVRDUDE_PROGRAMMER = usbtiny
#AVRDUDE_PRODUCT = t45

AVRDUDE_WRITE_FLASH = -U flash:w:$(TARGET).hex:i

AVRDUDE_FLAGS = -p $(MCU) -c $(AVRDUDE_PROGRAMMER)

## Build
all: $(TARGET).elf $(TARGET).hex $(TARGET).lss size

## Compile
%.o : %.c
	$(CC) $(INCLUDES) $(CFLAGS) -c  $<

##Link
%.elf: $(OBJECTS)
	 $(CC) $(LDFLAGS) $(OBJECTS) $(LINKONLYOBJECTS) -o $(TARGET).elf

%.hex: $(TARGET).elf
	avr-objcopy -O ihex $(HEX_FLASH_FLAGS)  $< $@

%.lss: $(TARGET).elf
	avr-objdump -h -S $< > $@

size: ${TARGET}.elf
	@echo
	@avr-size -C --mcu=${MCU} ${TARGET}.elf

erase:
	$(AVRDUDE) $(AVRDUDE_FLAGS) -e -U lfuse:w:$(LFUSE):m -U hfuse:w:$(HFUSE):m -U efuse:w:$(EFUSE):m

# Program the device.  
program: $(TARGET).hex
	$(AVRDUDE) $(AVRDUDE_FLAGS) $(AVRDUDE_WRITE_FLASH)

## Clean target
#.PHONY: clean
clean:
	-rm -rf $(OBJECTS) $(TARGET).elf $(TARGET).hex $(TARGET).lss $(TARGET).map 


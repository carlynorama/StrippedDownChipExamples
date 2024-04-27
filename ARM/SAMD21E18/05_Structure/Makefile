###############################################################################
# Makefile for a simple SAMD21 Assembly project
###############################################################################

TARGET ?= combined

CHIP ?= SAMD21E18A
MCU := cortex-m0plus

###############################################################################
## Resoruces
LINKER_FILE ?= $(CHIP)/linker.ld

SOURCES = $(wildcard *.s)# only this dir
SOURCES += $(wildcard *.S)# only this dir
SOURCES += startup.s# all dir in VPATH

VPATH=$(CHIP)#will look in this folder for missing files in sources.

OBJECTS = $(addsuffix .o, $(basename $(SOURCES)))#replaces any suffix

###############################################################################
## Tools
TOOL_BASE := arm-none-eabi-
CC := $(TOOL_BASE)gcc
AS := $(TOOL_BASE)as
OBJD := $(TOOL_BASE)objdump
DEBUGGER := $(TOOL_BASE)gdb
NM := $(TOOL_BASE)nm

PROGRAMMER := openocd

###############################################################################
## Flags

## Options common to compile, link and assembly rules
COMMON = -mcpu=$(MCU)
COMMON += -mthumb

## Compile options common for all C compilation units.
CFLAGS = $(COMMON)
CFLAGS += -Wall
CFLAGS += -g
#CFLAGS += -Os #compression

ASFLAGS = $(CFLAGS)

## Linker flags
LDFLAGS = $(COMMON)
LDFLAGS += --specs=nosys.specs -nostdlib -lgcc
LDFLAGS += -Wl,-Map=$(TARGET).map

# Programming & Debugging 
PRGMR_FILES_DIR = openocd/
PROGRAMMER_COMMON = -f $(PRGMR_FILES_DIR)segger.cfg#load hardware
PROGRAMMER_COMMON += -f $(PRGMR_FILES_DIR)$(CHIP).cfg#load chip description

FLASH_FLAGS = $(PROGRAMMER_COMMON)
FLASH_FLAGS += -f $(PRGMR_FILES_DIR)flash_program_prep.cfg
FLASH_FLAGS += -c "program $(TARGET).elf verify reset exit"

DEBUGGER_FILES_DIR = gdb/
DEBUG_FLAGS = -iex "target extended-remote localhost:3333"
DEBUG_FLAGS += -ex "layout regs"
DEBUG_FLAGS += -ex "source $(DEBUGGER_FILES_DIR)main_breakpoints.txt"

###############################################################################
## Rules

all: $(OBJECTS) $(TARGET).elf

## Assembler
%.o:%.s
	$(AS) $(ASFLAGS) $< -o $@

%.o:%.S
	$(CC) -x assembler-with-cpp -c $(CFLAGS) $< >$@

## Linker
$(TARGET).elf: $(OBJECTS)
	 $(CC) $(LDFLAGS) $(OBJECTS) $(LINKONLYOBJECTS)  -T./$(LINKER_FILE) -o $@
	
## Simple Checking 
%.lss: $(TARGET).elf
	$(OBJD) -h -S $< >$@

disamb: $(TARGET).elf
	$(OBJD) --disassemble $<

disamb_o: $(OBJECTS)
	$(OBJD) --disassemble $^

symb: $(TARGET).elf
	$(NM) --numeric-sort $<

symb_o: $(OBJECTS)
	$(NM) --numeric-sort $^

## Programming & Debugging  
flash: $(TARGET).elf
	$(PROGRAMMER) $(FLASH_FLAGS)


fnl: $(TARGET).elf
	$(PROGRAMMER) $(PROGRAMMER_COMMON) \
	-f $(PRGMR_FILES_DIR)flash_program_prep.cfg \
	-c "program $(TARGET).elf verify"

serve:
	$(PROGRAMMER) $(PROGRAMMER_COMMON)

talk: 
	telnet localhost 4444

debug: $(TARGET).elf
	$(DEBUGGER) $(TARGET).elf $(DEBUG_FLAGS)

## Utilities
clean:
	-rm -rf $(OBJECTS) $(TARGET).elf $(TARGET).map

# "resource check" - to get list of items make expects to find
res_check:
	@echo $(SOURCES)
	@echo $(OBJECTS)

## Phony List 
.PHONY: all talk debug res_check clean serve fnl flash symb disamb symb_o disamb_o

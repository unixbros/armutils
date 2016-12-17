LDFLAGS = --entry _start -nostdlib -static
ASFLAGS = -g
CC      = arm-none-eabi-gcc

all: cat echo pwd rm sync

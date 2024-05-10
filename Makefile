CC = arm-none-eabi-gcc

CWARNS = -Wall -Wextra 
CFLAGS = -mcpu=cortex-m0plus -mthumb -g -static -mfloat-abi=softfp --specs=nano.specs -std=c2x ${CWARNS}

OBJCOPY = arm-linux-gnueabi-objcopy

.PHONY: clean all

all: system.elf
	${OBJCOPY} -O ihex $^ system.hex

clean: 
	rm -f *.o
	rm -f *.hex
	rm -f *.elf

%.o: %.c
	${CC} ${CFLAGS} -c $^
%.o: %.s
	${CC} ${CFLAGS} -c $^
%.s: %.S
	${CC} ${CFLAGS} -E $^ > $@

TARGET_FILES = $(subst .c,.o,$(wildcard *.c)) $(subst .s,.o,$(wildcard *.s))

system.elf: ${TARGET_FILES}
	${CC} -T system.lds -o $@ $^ ${CFLAGS} -Wl,--print-memory-usage



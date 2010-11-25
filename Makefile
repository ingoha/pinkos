TARGET=pinkos

# hardcoded radio network address
DEVADDR = 0

# size of console line buffer
LINEBUF_MAX=32

# common libraries
LIBS = \
    os/pinkos.rel      \
    os/watchdog.rel    \
    os/clock.rel       \
    os/console.rel     \
    os/shell.rel       \
    os/parse.rel       \
    os/radio.rel       \
    os/packet.rel      

#SVNREV = `svn info | grep "Last Changed Rev" | sed -e "s/.*: //"`
SVNREV = 0


CC = sdcc 
CFLAGS = -Iinclude --no-pack-iram

CFLAGS += -DBUILD_VERSION=$(SVNREV) -DDEVADDR=$(DEVADDR) -DLINEBUF_MAX=$(LINEBUF_MAX)

ifneq ($(DEVICE),HANDSET)
CFLAGS += -DBOARD_IMME_DONGLE
LIBS += os/uart0.rel
else
CFLAGS += -DBOARD_IMME_HANDSET
LIBS += os/key.rel os/spi.rel os/lcd.rel os/tiles.rel os/lcdterm.rel
endif

all: $(TARGET).hex

%.rel : %.c
	$(CC) $(CFLAGS) -o $@ -c $<

$(TARGET).hex: $(LIBS)
	sdcc $(LFLAGS) $(LIBS)
	packihx < os/$(TARGET).ihx > $(TARGET).hex

install: $(TARGET).hex
	goodfet.cc erase
	goodfet.cc flash $(TARGET).hex
	goodfet.cc info
verify: $(TARGET).hex
	goodfet.cc verify $(TARGET).hex

clean:
	rm -f os/*.hex os/*.ihx os/*.rel os/*.asm os/*.lst os/*.rst os/*.sym os/*.lnk os/*.map os/*.mem
	rm -f *.hex *.ihx *.rel *.asm *.lst *.rst *.sym *.lnk *.map *.mem


## Is PinkOS communist? ##

No.

## Is PinkOS really an OS? ##

It depends on your definition. PinkOS is presently a bootloader.

If you want a "real operating system" for the CC1110, look at Keith Packard's [AltOS](http://keithp.com/git?p=altos.git;a=tree), the AltusMetrum 8051 operating system.

## How do I load PinkOS onto a board? ##

You need a Chipcon device programmer. I use a GoodFET. SmartRF and CCFlasher are other options.

http://travisgoodspeed.blogspot.com/2010/03/im-me-goodfet-wiring-tutorial.html

## Can I use PinkOS on an unmodified IM-Me dongle? ##

There's currently no support for communicating over the Cypress SPI interface. It may be possible.

## Are any other CC111x boards supported? ##

Not yet. But adding them should be easy.
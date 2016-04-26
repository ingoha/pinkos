# PinkOS #

PinkOS is a minimal operating system/bootloader for the <a href='http://www.youtube.com/watch?v=iKNA1l3ArK4'>Girl-Tech IM-Me</a> and CC111x.

http://code.google.com/p/pinkos/

It provides a bootloader with a command line console (either serially or using LCD + keyboard) and both peer-to-peer and broadcast packet radio.

PinkOS can boot other applications (http://code.google.com/p/pinkos/source/browse/trunk/apps/)

PinkOS is written in C and compiles with SDCC.

## Documentation ##

[README](http://code.google.com/p/pinkos/source/browse/trunk/README)

[CC111x datasheet](http://www.ti.com/lit/gpn/cc1110f32)

## Binaries ##

http://code.google.com/p/pinkos/source/browse/trunk/precompiled

## Building it ##
See [BuildPinkOS](BuildPinkOS.md)

## Contributing ##

Please do - the README contains a feature request list for PinkOS

Ideally, any IM-Me application should be bootable by PinkOS by adding `--code-loc 0x4000`.

## Developers ##

Joby Taffey <jrt@hodgepig.org>

[http://blog.hodgepig.org](http://blog.hodgepig.org)

[http://twitter.com/jobytaffey](http://twitter.com/jobytaffey)
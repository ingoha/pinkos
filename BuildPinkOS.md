# Building PinkOS #

These instructions assume that you have already built and configured a [goodfet](http://goodfet.sourceforge.net/tutorial/).


```
sudo apt-get install sdcc make
```


```
svn checkout http://pinkos.googlecode.com/svn/trunk pinkos
cd pinkos
```

[wire your goodfet to an IM-Me handset](http://travisgoodspeed.blogspot.com/2010/03/im-me-goodfet-wiring-tutorial.html)

wipe your IM-me

```
make erase
```

build and install a handset firmware with a network address of 1

```
make clean && make DEVICE=HANDSET DEVADDR=1 install
```

on the IM-me type
```
help
```

on the IM-me type
```
led 1
```


build and install an application

```
cd apps/speccan && make install
```

boot the application

```
boot
```
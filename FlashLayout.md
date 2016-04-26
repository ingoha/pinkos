
```
       Appllication code
0x4000 Application interrupt vectors
       PinkOS code
0x0000 PinkOS interrupt vectors
```

Each PinkOS ISR checks PSW.UD to see whether to handle interrupt in bootloader or application.

See:
http://code.google.com/p/pinkos/source/browse/trunk/pinkos/isr.c
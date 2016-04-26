# Attaching a serial port and 3.3V to an IM-me dongle #

Here is an unmodified dongle:<br>
<a href='http://farm2.static.flickr.com/1131/5099267353_4b36eba6dc_b.jpg'>
<img src='http://farm2.static.flickr.com/1131/5099267353_4b36eba6dc.jpg' alt='' border='0' />
</a>

<strong>Add an external power source:</strong>
<p>
On an unmodified IM-me dongle, 5V is supplied over USB. This drives the Cypress' internal voltage regulator which produces 3V for the CC1110.<br>
</p>
<p>
The board can be run with the Cypress powered down providing 3V directly into the CC1110. A regulated wall wart or 2xAA batteries both work. Connect your 3V power supply to ground and 3V on the dongle. The easiest connections are at the positive leg of the through hole capacitor and the GND pin of the USB plug.<br>
<p>
<strong>Disable the Cypress chip:</strong>
It seems that supplying 3V to the board has the side effect of powering up the Cypress chip. It will immediately start writing junk over the SPI lines which will interrupt the serial communications. To disable it, cut or lift the Cypress VCC pin. This is best done by heating the pin with a soldering iron then levering it up with a small screwdriver.<br>
<br>
<strong>Add serial:</strong>
<p>
Connect a <a href='http://www.sparkfun.com/products/10009'>standard 3V FTDI-type cable</a> to the Cypress pins marked MOSI and MISO. MOSI is transmit and MISO is receive.<br>
Connect the ground pin of your serial cable to GND on the board.<br>
</p>

Once the board is modified - here's a test firmware image:<br>
<pre>
:0400000002001B32AD<br>
:01000B0032C2<br>
:03001300020117D0<br>
:0300740002001671<br>
:0500160012007780FEDE<br>
:100077001200B01200DC1200CF43FD4012011A7AC1<br>
:10008700647B017C808A828B838CF0120144FD6043<br>
:10009700EE8D820ABA00010BC002C003C004120130<br>
:0900A70038D004D003D00280DC43<br>
:1001640057617272616E747920766F696465640D8B<br>
:020174000A007F<br>
:1000B000539ADFA2AFE433F452A82274FC55C9F579<br>
:1000C000F0740345F0F5C953C9FB43C90880FE43EA<br>
:1000D000F32843FD1443FE0275FF182253BEFBE5CF<br>
:1000E000BE30E6FB53C6B8E5C620E6FB43BE04229D<br>
:1000F000AA82AB831ABAFF011BC3E49A74808BF007<br>
:1001000063F08095F0500F7CB07D041CBCFF011D96<br>
:10011000EC4D70F780DE22C28B32AAF174FE5AF5E4<br>
:10012000F0740245F0F5F143F33C7586C075C222C8<br>
:1001300075C50CD28BD2AA228582C1E58630E1FB3F<br>
:040140005386FD22C3<br>
:06004A00E478FFF6D8FD8A<br>
:100028007900E94400601B7A0090017678007593A6<br>
:1000380000E493F2A308B800020593D9F4DAF27544<br>
:0200480093FF24<br>
:100050007800E84400600A7900759300E4F309D859<br>
:10006000FC7800E84400600C7900900000E4F0A304<br>
:04007000D8FCD9FAE5<br>
:0D001B00758107120160E582600302001686<br>
:1001440020F71430F6148883A88220F507E6A883E4<br>
:1001540075830022E280F7E49322E0227582002274<br>
:00000001FF<br>
</pre>

<pre>
$ goodfet.cc erase<br>
$ goodfet.cc flash dongle.hex<br>
</pre>
Connect to the serial port at 115200 8-N-1<br>
<br>
Driving the UART from C using SDCC looks like this:<br>
<pre>
void uart0rx_isr(void) __interrupt URX0_VECTOR<br>
{<br>
URX0IF = 0;<br>
// read U0DBUF and do something with it...<br>
}<br>
<br>
void uart_init(void)<br>
{<br>
PERCFG = (PERCFG & ~PERCFG_U0CFG) | PERCFG_U1CFG;<br>
P0SEL |= BIT5 | BIT4 | BIT3 | BIT2;<br>
<br>
U0CSR = 0x80 | 0x40;    // UART, RX on<br>
<br>
U0BAUD = 34;    // 115200<br>
U0GCR = 12;<br>
<br>
URX0IF = 1;<br>
URX0IE = 1;<br>
}<br>
<br>
void uart_putc(uint8_t ch)<br>
{<br>
U0DBUF = ch;<br>
while(!(U0CSR & U0CSR_TX_BYTE)); // wait for byte to be transmitted<br>
U0CSR &= ~U0CSR_TX_BYTE;         // Clear transmit byte status<br>
}<br>
</pre>
#include "LPC23xx.h"
void TargetResetInit(void)
{
	// 72 Mhz Frequency
	if ((PLLSTAT & 0x02000000) > 0)
	{
		/* If the PLL is already running */
		PLLCON &= ~0x02; /* Disconnect the PLL */
		PLLFEED = 0xAA; /* PLL register update sequence, 0xAA, 0x55 */
		PLLFEED = 0x55;
	}
	PLLCON &= ~0x01; /* Disable the PLL */
	PLLFEED = 0xAA; /* PLL register update sequence, 0xAA, 0x55 */
	PLLFEED = 0x55;
	SCS &= ~0x10; /* OSCRANGE = 0, Main OSC is between 1 and 20 Mhz */
	SCS |= 0x20; /* OSCEN = 1, Enable the main oscillator */
	while ((SCS & 0x40) == 0);
	CLKSRCSEL = 0x01; /* Select main OSC, 12MHz, as the PLL clock source */
	PLLCFG = (24 << 0) | (1 << 16); /* Congure the PLL multiplier and divider */
	PLLFEED = 0xAA; /* PLL register update sequence, 0xAA, 0x55 */
	PLLFEED = 0x55;
	PLLCON |= 0x01; /* Enable the PLL */
	PLLFEED = 0xAA; /* PLL register update sequence, 0xAA, 0x55 */
	PLLFEED = 0x55;
	CCLKCFG = 3; /* Congure the ARM Core Processor clock divider */
	USBCLKCFG = 5; /* Congure the USB clock divider */
	while ((PLLSTAT & 0x04000000) == 0);

	PCLKSEL0 = 0xAAAAAAAA; /* Set peripheral clocks to be half of main clock */
	PCLKSEL1 = 0x22AAA8AA;
	PLLCON |= 0x02; /* Connect the PLL. The PLL is now the active clock source */
	PLLFEED = 0xAA; /* PLL register update sequence, 0xAA, 0x55 */
	PLLFEED = 0x55;
	while ((PLLSTAT & 0x02000000) == 0);
	PCLKSEL0 = 0x55555555; /* PCLK is the same as CCLK */
	PCLKSEL1 = 0x55555555;
}
void delay(void)
{
	int i,j;
	for(i=0;i<0x7F;i++)
		for( j=0;j<0x7F;j++);
}
void send_serial_data(char ch)
{
	while ((U0LSR & 0x20)!=0x20);
	U0THR = ch;
}
void key_routine(void)
{
	unsigned int key;
	FIO3DIR = 0x008000FF;
	PINSEL0 |=0x00000000;
	IODIR0 |=0x00000000;
	while(1)
	{
		//First Row
		FIO4SET = 0x00000E00;
		key = FIO4PIN;
		key = (key & 0xF000) >> 12 ;
		if(key==0x07)
		{
			send_serial_data('0');
			FIO3PIN = 0x00000000;
		}
		if(key==0x0B)
		{
			send_serial_data('1');
			FIO3PIN = 0x00000001;
		}
		if (key==0x0D)
		{
			send_serial_data('2');
			FIO3PIN = 0x00000002;
		}
		if(key==0x0E)
		{
			send_serial_data('3');
			FIO3PIN = 0x00000003;
		}
		FIO4CLR = 0x00000E00;
		delay();
		//Second Row
		FIO4SET = 0x00000d00;
		key = FIO4PIN;
		key = (key & 0xF000) >> 12 ;
		if(key==0x07)
		{
			send_serial_data('4');
			FIO3PIN = 0x00000004;
		}
		if(key==0x0B)
		{
			send_serial_data('5');
			FIO3PIN = 0x00000005;
		}
		if(key==0x0D)
		{
			send_serial_data('6');
			FIO3PIN = 0x00000006;
		}
		if (key==0x0E)
		{
			send_serial_data('7');
			FIO3PIN = 0x00000007;
		}
		FIO4CLR = 0x00000D00;
		delay();
		//Third Row
		FIO4SET = 0x00000B00;
		key = FIO4PIN;
		key = (key & 0xF000) >> 12 ;
		if(key==0x07)
		{
			send_serial_data('8');
			FIO3PIN = 0x00000008;
		}
		if(key==0x0B)
		{
			send_serial_data('9');
			FIO3PIN = 0x00000009;
		}
		if(key==0x0D)
		{
			send_serial_data('A');
			FIO3PIN = 0x0000000A;
		}
		if (key==0x0E)
		{
			send_serial_data('B');
			FIO3PIN = 0x0000000B;
		}
		FIO4CLR = 0x00000B00;
		delay();
		//Fourth Row
		FIO4SET = 0x00000700;
		key = FIO4PIN;
		key = (key & 0xF000) >> 12 ;
		if(key==0x07)
		{
			send_serial_data('C');
			FIO3PIN = 0x0000000C;
		}
		if(key==0x0B)
		{
			send_serial_data('D');
			FIO3PIN = 0x0000000D;
		}
		if(key==0x0D)
		{
			send_serial_data('E');
			FIO3PIN = 0x0000000E;
		}
		if (key==0x0E)
		{
			send_serial_data('F');
			FIO3PIN = 0x0000000F;
		}
		FIO4CLR = 0x00000700;
		delay();
	}
}
int main ()
{
	unsigned int Fdiv;
	FIO4DIR = 0xFF000FFF;
	PINSEL0 = 0x00000050;
	U0LCR = 0x83; // 8 bits, no Parity, 1 Stop bit
	Fdiv = ( 72000000 / 16 ) / 19200 ; //baud rate
	U0DLM = Fdiv / 256;
	U0DLL = Fdiv % 256;
	U0LCR = 0x03; // DLAB = 0
	TargetResetInit();
	key_routine();
	return(0);
}

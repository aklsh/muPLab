#include "LPC23xx.h"

void delay(void)
{
	int i,j;
	for(i=0;i<0xff;i++)
		for( j=0;j<0xff;j++);
}

void key_press(void)
{
	unsigned int key;
	FIO3DIR = 0x050000FF;
	while(1)
	{
		//First Row
		FIO4SET = 0x00000E00;
		key = FIO4PIN;
		key = (key & 0xf000) >> 12 ;
		if(key!=0x0F)
		{
			FIO3SET =0X050000FF; // Set the relay and LED pins to logic 1
			delay();
			FIO3CLR =0x050000FF; // Clear the relay and LED pins (by assigning 1)
			FIO4CLR = 0x00000E00;
			delay();
		}
	}
}
int main ()
{
	FIO4DIR = 0xFF000FFF;
	FIO3DIR = 0x050000FF;
	PINSEL0 = 0x00000050;
	key_press();
	return(0);
}

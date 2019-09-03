#define F_CPU 1000000
#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>

ISR (INT1_vect)
{
	// Write your ISR here to blink the LED 10 times
	// with ON and OFF interval of 1 second each
	for(int i=0; i<10; i=i+1)
	{
		//PB0 is set to 1 for 1 sec.
		PORTB = 0x01;
		_delay_ms(1000);
		//PB0 is set to 0 for 1 sec.
		PORTB = 0x00;
		_delay_ms(1000);
	}
}

int main (void)
{
	//port i/o declarations
	DDRD = 0x00;
	DDRB = 0x01;
	MCUCR = 0x02;
	GICR = 0x80;
	PORTB = 0x00;

	//set interrupt flag of SREG
	sei();

	while (1)
	{
		//To keep the program running forever.
	}
}

#define F_CPU 1000000
#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>

ISR (INT1_vect)
{
	// Write your ISR here to blink the LED 10 times
	// with ON and OFF interval of 1 second each
	
}
int main(void)
{
	DDRD = ..... ;
	DDRB = ....;
	MCUCR = ....;
	GICR = ....;
	PORTB = .... ;
	
	.......;

	while (1)
	{
	}
}
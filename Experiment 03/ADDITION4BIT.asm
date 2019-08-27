/*
 *
 *	Addition of two unsigned nibbles taken from a DIP switch
 *
 *	INPUT - from DIP switch connected to PORTD
 *	OUTPUT - To the LEDs connected to PORTC
 *
 */

#include "m8def.inc"

START:
	LDI R16, 0x00;
	OUT DDRD, R16;  Setting PORTD to INPUT

	LDI R16, 0xFF;
	OUT DDRC, R16;  Setting PORTC to OUTPUT

ADDITION:
	IN R21, PIND;   R21 <-- (<NUM2><NUM1>)
	MOV R20, R21;   Making copy of R21 in R20 for having the 2 numbers in separate registers
	ANDI R20, 0xF0; Assigning R20 as "<NUM2>0000"
	SWAP R20;  Swapping higher and lower nibbles of R20. R20 <-- "0000<NUM2>"
	ANDI R21, 0x0F; Assigning R21 as "0000<NUM1>"
	ADD R20, R21;	R20 <-- R20 + R21

END:
    OUT PORTC, R20;	PORTD <-- R20
	NOP; End of program

/*
 *
 *	Multiplication of two unsigned nibbles taken from a DIP switch
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

	LDI R16, 0x00;	clearing productL register
	LDI R17, 0x00;	clearing productH register
	LDI R18, 0x00;	clearing temporary register

INPUT:
    IN R21, PIND;   R21 <-- (<NUM2><NUM1>)
    MOV R20, R21;   Making copy of R21 in R20 for having the 2 numbers in separate registers
    ANDI R20, 0xF0; Assigning R20 as "<NUM2>0000"
    SWAP R20;  Swapping higher and lower nibbles of R20. R20 <-- "0000<NUM2>"
    ANDI R21, 0x0F; Assigning R21 as "0000<NUM1>"

MULTIPLY1:
	CLC;	clear Carry Bit
	ROR R21;	right rotation of R1
	BRCC MULTIPLY2;    go to next step when last bit (carry now) is cleared.
	ADD R16, R20;
	ADC R17, R18;

MULTIPLY2:
	CLC;
	ROL R20;
	ROL R18;
	TST R21;
	BRNE MULTIPLY1;

END:
	OUT PORTC, R16;    Assigning only low byte of output to PORTC due to space constraint
	NOP;	End of Program

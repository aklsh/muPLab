/*
 *
 *	Checking if a given number is odd or even
 *
 *	INPUT - From FLASH Memory
 *	OUTPUT - To SRAM location 0x61 (result - 0x00 => even & 0x01 => odd)
 *
 */

.CSEG;	Start program

START:
	LDI ZL, LOW(NUM<<1);
	LDI ZH, HIGH(NUM<<1);	Z holds the FLASH address where the data is stored.
	LPM R0, Z;	Number loaded from FLASH
	LDI R17, 0x02;
	LDI R16,0x00;	Clearing Quotient to 0 initially

DIVIDE:
	keepSubtracting:	SUB R0,R17;	R0 <-- R0 - R17
	INC R16;	R16 = R16 + 1
	CP R17,R0;	Compare R17, R0
	BRLO keepSubtracting;	Subtract again if R17 < R0
	STS 0x61,R0;	Remainder to SRAM location 0x61

END:
	NOP;	End of program

NUM: .db 0xD3;

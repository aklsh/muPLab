/*
 *
 *	Division of two given numbers
 *
 *	INPUT - From FLASH Memory
 *	OUTPUT - To SRAM locations 0x62 (Quotient), 0x63 (Remainder)
 *
 */

.CSEG;	Start program

START:
	LDI ZL, LOW(NUM<<1);
	LDI ZH, HIGH(NUM<<1);	Z holds the FLASH address where the data is stored.
	LPM R0, Z+;	Numerator loaded from FLASH, then Z = Z + 1
	LPM R1, Z;	Denominator is loaded from the next location pointed by Z
	LDI R16, 0x00;	Clearing Quotient to 0 initially

DIVIDE:
	keepSubtracting:SUB R0,R1;	R0 <-- R0 - R1
	INC R16;	R16 = R16 + 1
	CP R1,R0;	Compare R1, R0
	BRLO keepSubtracting;	Subtract again if R1 < R0
	STS 0x62, R16;
	STS 0x63, R0;

END:
	NOP;	End of Program

NUM: .db 0xD3, 0x5F

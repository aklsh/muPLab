/*
 *		Addition of two 16 Bit Numbers
 *
 *		INPUT - From FLASH Memory
 *		OUTPUT - SRAM locations 0x60 (sumL), 0x61 (sumH), 0x62 (carry)
 *
 */

.CSEG; Start program

START:
	//Getting NUM1 from FLASH
	LDI ZL, LOW(NUM<<1);
	LDI ZH, HIGH(NUM<<1);	Z holds the FLASH address where the data is stored.
	LPM R0, Z+;
	LPM R1, Z+;

	//Getting NUM2 from FLASH
	LPM R20, Z+;
	LPM R21, Z;

	//Clearing Registers
	LDI R16, 0x00;	clearing sumL register
	LDI R17, 0x00;	clearing sumH register
	LDI R18, 0x00;	clearing carry register

ADDITION:
	//Initialising Low and High Bytes of result with NUM1
	MOV R16, R0;	R16 <-- R0
	MOV R17, R1;	R17 <-- R1

	ADD R16, R20; R16 <-- R16 + R20
	ADC R17, R21; R17 <-- R17 + R21 + C (from previous step)

	BRCC noCarry; Skip to storing values to SRAM
	LDI R18, 0x01;	making carry 1 if needed

	noCarry: STS 0x60, R16;	Storing value in R16 to SRAM location 0x60 (sumL)
	STS 0x61, R17;	Storing value in R17 to SRAM location 0x61 (sumH)
	STS 0x62, R18;	Storing value in R18 to SRAM location 0x62 (carry)

END:
	NOP;	End of program

NUM: .db 0xD3, 0x5F, 0xAB, 0xCD;

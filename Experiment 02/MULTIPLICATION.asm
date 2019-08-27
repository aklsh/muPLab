/*
 *
 *		Multiplication of two given numbers
 *
 *		INPUT - From FLASH Memory
 *		OUTPUT - To SRAM locations 0x60 (productL), 0x61 (productH)
 *
 *
 */

.CSEG;	Start Program

START:
	LDI ZL, LOW(NUM<<1);
	LDI ZH, HIGH(NUM<<1);	Z holds the FLASH address where the data is stored.
	LPM R0, Z+;	Multiplicand loaded from FLASH, then Z = Z + 1
	LPM R1, Z;	Multiplier is loaded from the next location pointed by Z
	LDI R16, 0x00;	clearing productL register
	LDI R17, 0x00;	clearing productH register
	LDI R18, 0x00;	clearing temporary register

MULTIPLY1:
	CLC;	clear Carry Bit
	ROR R1;	right rotation of R0
	BRCC MULTIPLY2;	go to next step when last bit (carry now) is cleared.
	ADD R16, R0;
	ADC R17, R18;

MULTIPLY2:
	CLC;
	ROL R0;
	ROL R18;
	TST R1;
	BRNE MULTIPLY1;
	STS 0x60, R16;	Storing value of R16 to SRAM location 0x60
	STS 0x61, R17;	Storing value of R17 to SRAM location 0x61

END:
	NOP;	End of Program

NUM: .db 0xD3, 0x5F; Inputs are defined in FLASH locations pointed by label NUM

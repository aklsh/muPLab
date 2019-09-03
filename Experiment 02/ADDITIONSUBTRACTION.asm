/*
 *
 *	Addition and Subtraction of two given numbers
 *
 *	INPUT - From SRAM locations 0x60 (num1) and 0x61 (num2)
 *	OUTPUT - To SRAM locations 0x62 (sumL), 0x63 (sumH), 0x64 (difference), 0x65 (sign of difference)
 *
 */

.CSEG;	Start program
START:
	LDS R0, 0x60;	Loading num1 from SRAM location 0x60 to R0
	LDS R1, 0x61;	Loading num2 from SRAM location 0x61 to R1

ADDITION:

	LDI R16, 0x00;	Clearing High Byte of SUM
	MOV R20, R0;	Creating a copy of R0 in R20 (to be used for subtraction)
	ADD R0, R1;	R0 <-- R0 + R1
	BRCC dontSetHighByte
	LDI R16, 0x01;	Setting High Byte of Sum to 0x01 if Carry is generated in the addition
	dontSetHighByte:	STS 0x62, R0;	Storing value in R0 (sumL) to SRAM location 0x62
	STS 0x63, R16;	Storing value in R16 (sumH) to SRAM location 0x63

SUBTRACTION:

	LDI R16, 0xFF;
	SUB R20, R1;	R20 <-- R20 - R1
	BRMI signIsNeg
	LDI R16, 0x00;	Setting Sign Byte to 0 if difference is positive
	signIsNeg:	STS 0x65, R16;	Storing value in R16 (sign) to SRAM location 0x65
	STS 0x64, R20;	Storing value in R20 (difference) in SRAM location 0x64

END:
	NOP;	End of program

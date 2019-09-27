;	Experiment 5b

	TTL sixteenBit
	AREA Program, CODE, READONLY
	ENTRY

Main
		LDR R0, list;
		LDR R1, mask1;
		LDR R2, mask2;
		LDR R3, mask3;
		LDR R4, mask4;


		AND R1, R1, R0;
		AND R2, R2, R0;
		AND R3, R3, R0;
		AND R4, R4, R0;

		MOV R4, R4, LSL #0x4;
		MOV R3, R3, LSL #0x8;
		MOV R2, R2, LSL #0xC;
		MOV R1, R1, LSL #0x10;

		ADD R1, R1, R2;
		ADD R3, R3, R4;
		ADD R0, R1, R3;
		STR R0, result;

		SWI &11;

list	DCD &0A0B0C0D;
	ALIGN

mask1	DCD &0F;
	ALIGN
mask2	DCD &0F00;
	ALIGN
mask3	DCD &0F0000;
	ALIGN
mask4	DCD &0F000000;
	ALIGN

result	DCD 0;
	END

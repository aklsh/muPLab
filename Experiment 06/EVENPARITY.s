;		Experiment 6a --- Even Parity

		TTL evenParity
		AREA Program, CODE, READONLY
		ENTRY
Main
		LDR R0, value;
		MOV R11, #32;
		MOV R5, #0;
		
loop
		AND R10, R0, #1;
		CMP R10, #1;
		BNE noIncrement;
		ADD R5, R5, #1;
		
noIncrement
		LSR R0, R0, #1;
		SUB R11, R11, #1;
		CMP R11, #0;
		BNE loop;
		
		AND R5, R5, #1;
		STR R5, result;
		
value	DCD &00000001;
		ALIGN
result	DCD 0
		END
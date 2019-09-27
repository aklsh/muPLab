;		Experiment 6c --- Sequence Detector

		TTL sequenceDetector
		AREA Program, CODE, READONLY
		ENTRY
Main
		LDR R0, List;
		EOR R1, R1, R1;
		MOV R3, #0xFF000000;
		MOV R6, #8;
		
loop1
		LDR R5, [R0];
		LSR R5, #8;
		ADD R3, R3, R5;
		MOV R4, #24;
		BL loop2
		
		LDR R5, [R0], #4;
		AND R5, R5, #0xFF;
		LSL R5, #16;
		ADD R3, R3, R5;
		MOV R4, #8;
		BL loop2;
		
		SUBS R6, R6, #1;
		BNE loop1;
finish
		STR R1, result;
stop	
		B stop;
		
loop2
		AND R2, R3, #0xFF000000;
		SUBS R2, R2, #0x7E000000;
		ADDEQ R1, R1, #1;
		SUBS R4, #1;
		LSL R3, #1;
		BNE loop2;
		BX LR;
		
result	DCW 0;
		ALIGN
			
start	
		DCD &00000000;
		DCD &00000000;
		DCD &000007E0;
		DCD &00000007;
		DCD &E0000000;
		DCD &00000000;
		DCD &00000000;
		DCD &00000000;
		ALIGN
			
List	DCD start;
	
		END

;
; int1.asm
;
; Created: 03-09-2019 00:34:52
; Author : Anand
;


; Replace with your application code
.org 0
rjmp reset

.org 0x0002
rjmp int1_ISR

.org 0x0100

reset:
      LDI R16,0x70
	  OUT SPL,R16
	  LDI R16,0x00
	  OUT SPH,R16

	  LDI R16,0x01
	  OUT DDRB,R16

	  LDI R16,0x00
	  OUT DDRD,R16

	  IN R16,.....;Load MCUCR register 
	  ORI R16,.....
	  OUT ......,.....

	  IN R16,.....; Load GICR register 
	  ORI R16,.....
	  OUT .....,.....

	  LDI R16,0x00
	  OUT PORTB,R16

	  SEI
ind_loop:rjmp ind_loop

int1_ISR:IN R16,SREG
		 ..... R16

		 LDI R16,......
		 MOV R0,R16

	c1:	 LDI R16,......
		 OUT PORTB,R16

		 LDI R16,0xFF
	a1:	 LDI R17,0xFF
	a2:	 DEC R17
		 BRNE .....
		 DEC R16
		 BRNE .....
		 
		 LDI R16,0x00
		 OUT PORTB,R16

		 LDI R16,0xFF
	b1:	 LDI R17,0xFF
	b2:	 DEC R17
		 BRNE .....
		 DEC R16
		 BRNE .....

		 DEC R0
		 BRNE .....
		 ..... R16
		 OUT SREG,R16
		 
		 ...... 

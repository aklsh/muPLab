/*
 *		Addition of a list of numbers
 *
 *		INPUT - From FLASH Memory
 *		OUTPUT - SRAM locations 0x60 (sumL), 0x61 (sumH)
 *
 */

.CSEG; Start program

START:
    //Getting number of numbers to be added from FLASH
    LDI ZL, LOW(NUM<<1);
    LDI ZH, HIGH(NUM<<1);   Z holds the FLASH address where the data is stored.
    LPM R0, Z+; R0 holds the number of numbers to be added

    //Clearing output and temporary registers
    LDI R16, 0x00;  sumL register
    LDI R17, 0x00;  sumH register
    LDI R20, 0x00;  temporary register to hold value of new number

ADDITION:
    getNextNumber:  LPM R1, Z+; R1 holds the next number
    MOV R20, R1;    R20 <-- R1
    ADD R16, R20;   R16 <-- R16 + R20
    BRCC noCarry;
    INC R17;    R17 <-- R17 + 1 ==> if carry was generated in previous step
    noCarry: DEC R0; R0 <-- R0 - 1
    BRNE getNextNumber; go to next number

END:
    STS 0x60, R16;  Storing value in R16 to SRAM location 0x60
    STS 0x61, R17;  Storing value in R17 to SRAM location 0x61
    NOP;    End of program

NUM: .db 0x03, 0x5F, 0x32, 0x01; 

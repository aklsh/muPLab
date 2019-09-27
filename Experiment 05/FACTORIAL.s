;   Experiment 5a

    TTL factorial
    AREA Program, CODE, READONLY
    ENTRY

Main
        MOV  R0, #1;
        MOV  R1, #6;
        MOV  R3, #1;
        BL multNext;
        B Stop;

multNext
        MUL R4, R3, R0;
        MOV R3, R4;
        ADD R0, R0, #1;
        CMP R0, R1;
        BLE multNext;
        MOV PC, LR;

Stop
        B Stop

    END

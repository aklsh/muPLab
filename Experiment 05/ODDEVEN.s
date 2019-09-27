;   Experiment 5c

    TTL oddEven
    AREA Program, CODE, READONLY
    ENTRY

Main
        MOV  R0, #1;
        MOV  R1, #6;
        AND R2, R1, R0;

Stop
        B Stop;

    END

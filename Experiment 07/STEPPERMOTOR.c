#include "LPC23xx.h"

void delay()
{
    int i, j;
    
    for(i = 0;i < 0xFF; i++)
        for(j = 0;j < 0xFF; j++);
}

int main()
{
    IODIR0 = 0xFFFFFFFF;

    while(1)
    {
        IOPIN0 = 0x00000280;
        delay();
        IOPIN0 = 0x00000240;
        delay();
        IOPIN0 = 0x00000140;
        delay();
        IOPIN0 = 0x00000180;
        delay();
    }
    return 0;
}

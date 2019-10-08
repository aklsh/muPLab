#include "LPC23xx.h"

void delayShort()
{
    int i;

    for(i = 0;i < 0x0F; i++);
}

void delayLong()
{
    int i;

    for(i = 0;i < 0xFF; i++);
}

int main()
{
    IODIR0 = 0xFFFFFFFF;

    while(1)
    {
        IOPIN0 = 0x00000280;
        delayShort();
        IOPIN0 = 0x00000240;
        delayShort();
        IOPIN0 = 0x00000140;
        delayShort();
        IOPIN0 = 0x00000180;
        delayLong();
        IOPIN0 = 0x00000140;
        delayShort();
        IOPIN0 = 0x00000240;
        delayShort();
        IOPIN0 = 0x00000280;
        delayShort();
    }
    return 0;
}

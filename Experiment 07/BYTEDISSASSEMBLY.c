#include "LPC23xx.h"

int main()
{
    int a;
    int highByte;
    int lowByte;
    FIO3DIR = 0xFF:
    FIO4DIR = 0x00;

    while(1)
    {
        a = FIO4PIN;
        highByte = a & 0xF0;
        highByte = highByte >> 4;
        lowByte = a & 0x0F;
        FIO3PIN = highByte * lowByte;
    }
    return 0;
}

#include "LPC23xx.h"

void dLAY(int n)
{
    int i,j;
    for(i=0;i<n;i++)
        for(j=0;j<0x0F;j++);
}

int main (void)
{
    PCLKSEL0=0x00C00000;
    PINMODE1=0x00300000;
    PINSEL1=0x00200000;
    int value;
    int i=0;
    while(1)
    {
        //Triangular Wave
        value=0;
        while(value!=1023)
        {
            DACR=((1<<16)|(value<<6));
            value++;
        }
        while (value!= 0)
        {
            DACR=((1<<16)|(value<<6));
            value--;
        }
    }
    return 0;
}

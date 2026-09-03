#include <stdio.h>

int main()
{
    // Name: Serene Plummer
    // EUID: sp3155

    unsigned char ch;
    int i;
    int temp;

    printf("Enter an ASCII character: ");
    scanf("%c", &ch);

    printf("The ASCII value of %c is:\n", ch);
    printf("dec - %d\n", ch);
    printf("hex - %x\n", ch);
    printf("bin --\n");

    for (i = 7; i >= 0; i--)
    {
        temp = ch >> i;

        if (temp & 1)
        {
            printf("1");
        }
        else
        {
            printf("0");
        }
    }

    printf("\n");

    return 0;
}
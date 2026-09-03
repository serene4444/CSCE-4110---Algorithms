/* Name: Serene
   EUID:s1`3p3155
*/

#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    int *numbers;
    int temp;

    numbers = malloc(2 * sizeof(int));

    if (numbers == NULL)
    {
        printf("Error: Memory allocation failed.\n");
        return 1;
    }

    printf("Enter first integer: ");
    scanf("%d", &numbers[0]);

    printf("Enter second integer: ");
    scanf("%d", &numbers[1]);

    printf("Original values: 1st = %d , 2nd = %d\n", numbers[0], numbers[1]);

    temp = numbers[0];
    numbers[0] = numbers[1];
    numbers[1] = temp;

    printf("Swapped values: 1st = %d , 2nd = %d\n", numbers[0], numbers[1]);

    free(numbers);

    return 0;
}
// This is a test of how this works 
#include <stdio.h>
int main()
{
// declare some variables here 
int num1 = 4;
float num2 = 3.5;

// print the result
printf("The result is %f\n", num1 * num2); // this does it

/* does it work? */ return 0;
}


/* 
Write a one-line sed command that transforms all of the C++ style (i.e., single-line
comments) to the C-style (i.e., multi-line comments) so that after running the
appropriate sedcommand, the following would be output to the terminal:  
*/

/*
solution: sed 's/\/\/\(.*\)$/\/\* \1 \*\//g' myprog.c 
*/

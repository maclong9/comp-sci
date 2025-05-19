#include "../include/cs50.h"
#include <stdio.h>
#include <stdlib.h>

int calculate(int *x, char *o, int *y) {
  switch (*o) {
  case '+':
    return *x + *y;
  case '-':
    return *x - *y;
  case '/':
    return *x / *y;
  case '*':
    return *x * *y;
  default:
    fprintf(stderr, "Unsupported operator\n");
    exit(1);
  }
}

int main(void) {
  printf("Calculator: Please enter x, then an operator and then y\n");
  printf("Operators: + = Add, - = Subtract, / = Divide and * = Multiply.\n");

  int x = get_int("x: ");
  char o = get_char("o: ");
  int y = get_int("y: ");
  int r = calculate(&x, &o, &y);

  printf("%i %c %i = %i\n", x, o, y, r);
}

#include <stdio.h>

void addresses() {
  int n = 50;
  int *p = &n;
  char *s = "HI!";

  printf("N Address: %p\n", p);
  printf("N Value: %i\n", *p);

  printf("S Address: %p\n", s);
  printf("S[0] Address: %p\n", &s[0]);
  printf("S[1] Address: %p\n", &s[1]);
  printf("S[2] Address: %p\n", &s[2]);
  printf("S[3] Address: %p\n", &s[3]);
}

void pointer_arithmetic(void) {
  char *s = "HI!";
  printf("%c", *s);
  printf("%c", *(s + 1));
  printf("%c", *(s + 2));
}

int main(void) {
  addresses();
  pointer_arithmetic();
}

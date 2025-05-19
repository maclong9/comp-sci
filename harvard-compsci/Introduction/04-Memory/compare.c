#include "../include/cs50.h"
#include <stdio.h>
#include <string.h>

void intergers(void) {
  int i = get_int("i: ");
  int j = get_int("j: ");

  if (i == j) {
    printf("Same\n");
  } else {
    printf("Different\n");
  }
}

void strings(void) {
  char s[20];
  char t[20];
  printf("s: ");
  scanf("%s", s);
  printf("t: ");
  scanf("%s", t);

  if (strcmp(s, t) == 0) {
    printf("Same\n");
  } else {
    printf("Different\n");
  }
}

int main(void) {
  intergers();
  strings();
}

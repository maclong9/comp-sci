#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int get_int(char *text) {
  int value;
  printf("%s", text);
  scanf("%i", &value);

  while (value < 0) {
    printf("%s", text);
    scanf("%i", &value);
  }

  return value;
}

void request_char(char *text, char *value) {
  printf("%s", text);
  scanf("%c", value);
}

char get_char(char *text) {
  char value;

  request_char(text, &value);

  while (strlen(&value) != 1) {
    request_char(text, &value);
  }

  return value;
}

#include "../include/cs50.h"
#include <ctype.h>
#include <stdio.h>

void check_response(char response) {
  if (tolower(response) == 'y') {
    printf("Agreed.\n");
  } else if (tolower(response) == 'n') {
    printf("Not agreed.\n");
  }
}

int main(void) {
  char agree_string[19] = "Do you agree? Y/N: ";
  char response = get_char(agree_string);

  while (tolower(response) != 'y' && tolower(response) != 'n') {
    // FIXME: prints twice because of while loop inside `get_char`
    response = get_char(agree_string);
  }

  check_response(response);
}

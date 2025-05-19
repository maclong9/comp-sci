#include "../include/cs50.h"
#include <stdio.h>

void printBlock(int size) {
  for (int i = 0; i < size; i++) {
    for (int i = 0; i < size; i++) {
      printf("#");
    }
    printf("\n");
  }
}

int main(void) {
  int size = get_int("Size");
  int amount = get_int("Amount");

  for (int i = 0; i < amount; i++) {
    printBlock(size);
  }
}

#include "../include/cs50.h"
#include <stdio.h>
#include <string.h>
#include <unistd.h>

void print_hello(char *name, int n, int *age) {
  for (int i = 0; i < n; i++) {
    printf("%i: Hello, %s\n", i, name);
    sleep(1);
  }

  if (*age < 18) {
    printf("at age %i you are a child\n", *age);
  } else {
    printf("at age %i you are an adult\n", *age);
  }
}

int main(void) {
  char *name;
	printf("Enter your name: ");
	scanf("%s", name);
  int age = get_int("Enter your age: ");
  print_hello(name, 3, &age);
}

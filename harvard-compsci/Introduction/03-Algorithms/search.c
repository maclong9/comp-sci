#include <stdio.h>
#include <string.h>

int linear(void) {
  int numbers[] = {20, 500, 10, 5, 100, 1, 50};

  int n;
  printf("Number: ");
  scanf("%i", &n);

  for (int i = 0; i < 7; i++) {
    if (numbers[i] == n) {
      printf("Found \n");
			return 0;
    } 
  }
	printf("Not Found \n");
	return 1;
}


int main(void) { // Linear with Strings
	char *strings[] = {"battleship", "boot", "cannon", "iron", "thimble", "top hat"};
	char *input;

	printf("String: ");
	scanf("%s", input);

	for(int i = 0; i < 6; i++) {
		if(strcmp(strings[i], input) == 0) {
			printf("Found\n");
			return 0;
		}
	}
	printf("Not Found\n");
	return 1;
}

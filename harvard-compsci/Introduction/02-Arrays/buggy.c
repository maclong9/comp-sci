#include <stdio.h>

// This code contains a bug for testing debuggers.
void print_column(int height) {
	for (int i = 0; i <= height; i++) {
		printf("#\n");
	}
}

int main(void) {
	int h;
	printf("Height: ");
	scanf("%i", &h);
	print_column(h);
}

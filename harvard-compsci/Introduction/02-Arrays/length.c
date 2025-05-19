#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int string_length(char* string) {
	int n = 0;
	while(string[n] != '\0') {
		n++;
	}

	return n;
}

int main(void) {
	char *name = malloc(51 * sizeof(char));
	printf("Name: ");
	scanf("%s", name);

	printf("Name Length: %i\n", string_length(name));
	printf("Name Length: %lu\n", strlen(name));
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int main(void) {
	char *s = malloc(51 * sizeof(char));
	printf("Before: ");
	scanf("%s", s);
	
	printf("After: ");
	for (int i = 0, n = strlen(s); i < n; i++) {
		printf("%c", toupper(s[i]));
	}
	printf("\n");
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
	FILE *file = fopen("phonebook.csv", "a");
	char *name =  malloc(50 * sizeof(char)); 
	char *number = malloc(20 * sizeof(char));

	if(file == NULL) {
		return 1;
	}

	printf("Name: ");
	scanf("%s", name);
	printf("Number: ");
	scanf("%s", number);

	fprintf(file, "%s,%s\n", name, number);

	fclose(file);
}

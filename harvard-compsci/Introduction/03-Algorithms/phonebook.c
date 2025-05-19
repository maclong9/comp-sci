#include <stdio.h>
#include <string.h>

typedef struct {
	char *name;
	char *number;
} person;

int main(void) {
	person people[4];
	people[0].name = "Mac";
	people[0].number = "+01234";
	people[1].name = "Alice";
	people[1].number = "+43210";
	people[2].name = "Heidi";
	people[2].number = "+56789";
	people[3].name = "Zeri";
	people[3].number = "+56789";

	char name[20];
	printf("String: ");
	scanf("%s", name);

	for(int i = 0; i < 3; i++) {
		if(strcmp(people[i].name, name) == 0) {
			printf("Found: %s\n", people[i].number);
			return 0;
		}
	}

	printf("Not Found\n");
	return 1;
}

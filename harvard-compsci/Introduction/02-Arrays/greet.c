#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {
	if (argc == 2) {
		printf("hello, %s\n", argv[1]);
	} else if (argc > 2) {
		for(int i = 0; i < argc; i++) {
			printf("%s ", argv[i]);
		}
	} else {
		printf("Hello, World!");
	}
}

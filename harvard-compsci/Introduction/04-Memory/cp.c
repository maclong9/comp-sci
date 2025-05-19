#include <stdio.h>
#include <stdint.h>

int main(int arggc, char *argv[]) {
	FILE *src = fopen(argv[1], "rb");
	FILE *dst = fopen(argv[2], "wb");

	uint8_t b;

	while(fread(&b, sizeof(b), 1, src) != 0) {
		fwrite(&b, sizeof(b), 1, dst);
	}

	fclose(dst);
	fclose(src);
}

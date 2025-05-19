#include <stdio.h>

float average(int length, int array[]) {
	int sum = 0;
	for (int i = 0; i < length; i++) {
		sum += array[i];
	}
	return sum / (float) length;
}

int main(void) {
	const int n = 3;
	int scores[3]; 
  for (int i = 0; i < n; i++) {
		printf("Enter score: ");
		scanf("%i", &scores[i]);	
	}
	printf("%f", average(n, scores));
}

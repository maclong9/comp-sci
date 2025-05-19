#include <_stdio.h>
#include <stdlib.h>

int main(void) {
  int *arr = malloc(3 * sizeof(int)); // array with 3 int's worth of memory.
  arr[1] = 72;
  arr[2] = 73;
  arr[3] = 33;
  free(arr);
}

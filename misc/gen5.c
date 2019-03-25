/* Generate a bunch of 5-divisible numbers in binary */

#include <stdio.h>
 
int main()
{
  int n, c, k;
 
  for (n = 0; n < 500; n += 5) {
    for (c = 31; c >= 0; c--)
    {
      k = n >> c;
 
      if (k & 1)
        printf("1");
      else
        printf("0");
    }
 
    printf("\n");
  }
  return 0;
}

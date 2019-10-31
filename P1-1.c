/*	               
Name: Johnathan Radcliff
Date: 09/27/19

This program loads a pile and finds the color of the topmost piece. */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define DEBUG 0 // RESET THIS TO 0 BEFORE SUBMITTING YOUR CODE

int main(int argc, char *argv[]) {
   int	             PileInts[1024];
   int	             NumInts, TopColor=0;
   int  Load_Mem(char *, int *);
   // This allows you to access the pixels (individual bytes)
   // as byte array accesses (e.g., Pile[25] gives pixel 25):
   char *Pile = (char *)PileInts;

   if (argc != 2) {
     printf("usage: ./P1-1 valuefile\n");
     exit(1);
   }
   NumInts = Load_Mem(argv[1], PileInts);
   if (NumInts != 1024) {
      printf("valuefiles must contain 1024 entries\n");
      exit(1);
   }

   if (DEBUG){
     printf("Pile[0] is Pixel 0: 0x%02x\n", Pile[0]);
     printf("Pile[107] is Pixel 107: 0x%02x\n", Pile[107]);
   }

  /* Your program goes here */
   clock_t t;
   t = clock();
  // answer byte
  int ans = 0b11111110;
  // for every pixel in the array
  for (int i = 64; i < 4032; i++) {
    // grab the pixel of focus
    int pix = Pile[i];
    // if it's still a potential answer
    if ((ans >> pix) & 1) {
      // find the adjacent pixels
      int l_pix = Pile[i - 1];         
      int r_pix = Pile[i + 1];
      int t_pix = Pile[i - 64];
      int b_pix = Pile[i + 64];
      // find if overlap exists
      if (l_pix == r_pix && l_pix != pix) {
        // if overlap exists, set the overlapped value to zero
        // if the pixel is in the answer byte, remove it; otherwise, no need to touch it
        if ((ans >> l_pix) & 1) {
          ans -= 1 << l_pix;
          printf("%d\n", ans);
          // if ((1 << l_pix) == 8) {
          //   printf("left: %d, center: %d, right: %d, ans: %d\n", l_pix, pix, r_pix, ans);
          // }
        }
        // check the top and bottom pixels if there's no left or right overlap
      } else if (t_pix == b_pix && t_pix != pix) {
        if ((ans >> t_pix) & 1) {
          ans -= 1 << t_pix;
          printf("%d\n", ans);
          // if ((1 << t_pix) == 8) {
          //   printf("top: %d, center: %d, bottom: %d, ans: %d\n", t_pix, pix, b_pix, ans);
          // }
        }
      }
    }
  }
  int j = -1;
  
  do {
    ans = ans >> 1;
    j++;
  } while (ans != 0);

  TopColor = j;
  printf("The topmost part color is: %d\n", TopColor);
  t = clock() - t;
  double time = ((double) t / CLOCKS_PER_SEC);
  printf("time elapsed: %f\n", time);
  exit(0);
}

/* This routine loads in up to 1024 newline delimited integers from
a named file in the local directory. The values are placed in the
passed integer array. The number of input integers is returned. */

int Load_Mem(char *InputFileName, int IntArray[]) {
   int	N, Addr, Value, NumVals;
   FILE	*FP;

   FP = fopen(InputFileName, "r");
   if (FP == NULL) {
      printf("%s could not be opened; check the filename\n", InputFileName);
      return 0;
   } else {
      for (N=0; N < 1024; N++) {
         NumVals = fscanf(FP, "%d: %d", &Addr, &Value);
         if (NumVals == 2)
            IntArray[N] = Value;
         else
            break;
      }
      fclose(FP);
      return N;
   }
}
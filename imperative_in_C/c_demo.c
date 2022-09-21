/*
Do the matrix encryption exercise with pointers and goto
*/

#include <stdio.h>
#include <stdlib.h>

void matrix_encrypt (char* s, int n, int cols) {
  int rows = 0;
  if (n % cols == 0) {
    rows = n / cols;
  }
  else {
    rows = (n / cols) + 1;
  }

  for (int i=0; i<n; i++) {
    // i = j * rows + k
    int j = i / rows;
    int k = i % rows;
    printf("%c",s[ k * cols + j ]);
  }
  printf("\n");
}

void matrix_encrypt_pointer (char* s, int n, int cols) {
  int rows = 0;
  if (n % cols == 0) {
    rows = n / cols;
  }
  else {
    rows = (n / cols) + 1;
  }

  for (int i=0; i<n; i++) {
    // i = j * rows + k
    int j = i / rows;
    int k = i % rows;
    printf("%c", *(s + k * cols + j));
  }
  printf("\n");
}

void matrix_encrypt_goto (char* s, int n, int cols) {
  int rows = 0;
  if (n % cols == 0) {
    rows = n / cols;
  }
  else {
    rows = (n / cols) + 1;
  }

  int i = 0;
  loop: ;

    // i = j * rows + k
    int j = i / rows;
    int k = i % rows;
    printf("%c", *(s + k * cols + j));

    i++;
    if (i < n){
      goto loop;
    }
  printf("\n");
}


int main () {
  matrix_encrypt ("Secret text" ,11 ,3) ;
  matrix_encrypt ("Secret text" ,11 ,2) ;
  matrix_encrypt ("Secrettext" ,10 ,5) ;
  printf("\n");
  matrix_encrypt_pointer ("Secret text" ,11 ,3) ;
  matrix_encrypt_pointer ("Secret text" ,11 ,2) ;
  matrix_encrypt_pointer ("Secrettext" ,10 ,5) ;
  printf("\n");
  matrix_encrypt_goto ("Secret text" ,11 ,3) ;
  matrix_encrypt_goto ("Secret text" ,11 ,2) ;
  matrix_encrypt_goto ("Secrettext" ,10 ,5) ;
  printf("\n");
}

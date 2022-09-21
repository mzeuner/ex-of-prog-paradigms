/*
Do the matrix encryption exercise with pointers and goto
*/

#include <stdio.h>
#include <stdlib.h>

void matrix_encrypt (char s[], int n, int cols) {

  for(int j=0; j<cols; j++){
    for(int i=j; i<n; i+=cols){
      printf("%c",s[i]);
    }
  }
  printf("\n");
}

void matrix_encrypt_pointer (char s[], int n, int cols) {

  for(int j=0; j<cols; j++){
    for(int i=j; i<n; i+=cols){
      printf("%c", *(s+i));
    }
  }
  printf("\n");
}

void matrix_encrypt_goto (char* s, int n, int cols) {

  int o=0;
  int i=o;
  outerLoop:
    i=o;
    innerLoop:
      printf("%c", *(s+i));
      i+=cols;
      if(i<n){ goto innerLoop; }
    o++;
    if(o<cols){ goto outerLoop; }
  printf("\n");

}

void matrix_decrypt (char* s, int n, int cols) {

  int rows = 0;
  if (n % cols == 0) {
    rows = n / cols;
  }
  else {
    rows = (n / cols) + 1;
  }

  for(int j=0; j<rows; j++){
    for(int i=j; i<n; i+=rows){
      printf("%c", *(s+i));
    }
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
  matrix_decrypt ("Sr xeettcte" ,11 ,3) ;
  matrix_decrypt ("Sce eterttx" ,11 ,2) ;
  matrix_decrypt ("Stetcerxet" ,10 ,5) ;
}

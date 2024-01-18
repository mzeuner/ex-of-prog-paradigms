# Matrix cipher

## Exercise 1 (🌶🌶)
Write a function
```c
void matrix_encrypt(char s[], int n, int cols)
```
that takes a string `s` of length `n` and encrypts it by
"writing" the string into a matrix with `cols` columns,
row for row as shown in the example below. The function
should then *print* out the string that we get by "reading" the matrix column by column.


**Example:** In order to encrypt `Secret text` with *3* columns,
we create the following matrix

S | e | c
---|---|---
r | e | t
" " | t | e
x | t | ""

Note that the number of rows is thus implicitly given by the length of the
input string and the number of columns.

The ciphered text should then be `Sr xeettcte`.


**Test:** if you run
```c
int main () {
matrix_encrypt ("Secret text" ,11 ,3) ;
matrix_encrypt ("Secret text" ,11 ,2) ;
matrix_encrypt ("Secrettext" ,10 ,5) ;
}
```
you should get
```
Sr xeettcte
Sce eterttx
Stetcerxet
```

## Exercise 2 (🌶)
Write a function
```c
void matrix_encrypt_pointer(char* s, int n, int cols)
```
that works just like `matrix_encrypt`
but uses pointers and pointer arithmetic instead of array-indexing.

## Exercise 3 (🌶)
Write a function `matrix_encrypt_goto` that works just like `matrix_encrypt`
but uses `goto`-statements instead of `while` or `for` loops.


## Exercise 4 (🌶🌶)
Write a function
```c
void matrix_decrypt (char* s, int n, int cols)
```
that reverses `matrix_encrypt`, e.g. running
```c
int main () {
matrix_decrypt ("Sr xeettcte" ,11 ,3) ;
matrix_decrypt ("Sce eterttx" ,11 ,2) ;
matrix_decrypt ("Stetcerxet" ,10 ,5) ;
}
```
should get you
```
Secret text
Secret text
Secrettext
```

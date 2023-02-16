# Polynomials with integer coefficients

In this exercise session we want to represent polynomials as
lists of coefficients. For simplicity we restrict our attention
to polynomials with integer coefficients. The polynomial
`1+2x+3x²+4x³` for example is represented by the list `[1,2,3,4]`.

This is a *one-to-many* relation: a polynomial can be represented by several lists.
In our example, both `[1,2,3,4]` and `[1,2,3,4,0,0]` represent the same polynomial, as
`1+2x+3x²+4x³ = 1+2x+3x²+4x³+0x⁴+0x⁵`. Adding zeros at the end of a list thus doesn't
give a new polynomial.


## Exercise 1

We can define polynomials as the following data type:

```haskell
data IntPoly = P [Int]
```

We want to equip this type with instances of common type classes.

### Exercise 1.1 (🌶)

Write a function

```haskell
dropZeros :: [Int] -> [Int]
```

that deletes the trailing zeros of a list, e.g. `dropZeros [1,2,3,0,0] = [1,2,3]`
This can then be used to make our polynomials an instance of the type class `Eq`:

```haskell
instance (Eq IntPoly) where
  P xs == P ys = dropZeros xs == dropZeros ys
```
### Exercise 1.2 (🌶🌶)

Write a function

```haskell
polyToString :: [Int] -> String
```

that "prints" the polynomial represented by a list correctly, e.g.

```haskell
polyToString [1,1,0,2,0] = "1 + x + 2x^3"
polyToString [-1,-1,0,-2,0] = "-1 - x - 2x^3"
```

This can then be used to make our polynomials an instance of the type class `Show`:

```haskell
instance (Show IntPoly) where
  show (P xs) = polyToString xs
```


## Exercise 2

We want to equip polynomials with algebraic operations and put them to test.

### Exercise 2.1 (🌶)

Write a function

```haskell
addPoly :: [Int] -> [Int] -> [Int]
```

that corresponds to addition of polynomials.

### Exercise 2.2 (🌶🌶)

Write a function

```haskell
derPoly :: [Int] -> [Int]
```

that corresponds to taking the derivative of a polynomial, e.g.
`der (2 + 2x + 3x² + 7x³ + 6x⁵) = 2 + 6x + 21x² + 30x⁴`

### Exercise 2.3 (🌶🌶🌶)

Write a function

```haskell
mulPoly :: [Int] -> [Int] -> [Int]
```

that corresponds to multiplication of polynomials, e.g.
`(1 + x + 2x³) · (2 + 3x²) = 2 + 2x + 3x² + 7x³ + 6x⁵`

### Bonus exercise 2.4 (💫)

Read about Haskell's `QuickCheck` feature. Write a function

```haskell
myTest :: [Int] -> [Int] -> Bool
```

that "tests" the multiplicative rule for derivation:

```
der (p · q) = (der p) · q + p · (der q)
```

Write a  `main` function that runs `QuickCheck` on `myTest`.

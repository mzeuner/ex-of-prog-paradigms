# Polynomials with integer coefficients

In this exercise session we want to represent polynomials as
lists of coefficients


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

### Exercise 2.3 (🌶🌶)

Write a function

```haskell
derPoly :: [Int] -> [Int]
```

that corresponds to multiplication of polynomials, e.g.
`der (2 + 2x + 3x² + 7x³ + 6x⁵) = 2 + 6x + 21x² + 30x⁴`

### Exercise 2.3 (🌶🌶🌶)

Write a function

```haskell
mulPoly :: [Int] -> [Int] -> [Int]
```

that corresponds to multiplication of polynomials, e.g.
`(1 + x + 2x³) · (2 + 3x²) = 2 + 2x + 3x² + 7x³ + 6x⁵`

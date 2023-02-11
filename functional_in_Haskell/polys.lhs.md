# Polynomials with integer coefficients

In this exercise session we want to represent polynomials as
lists of coefficients


## Exercise 1

We can define polynomials as the following data type:

```haskell
data IntPoly = P [Int]
```

We want to equip this type with instances of common type classes

### Exercise 1.1 (🌶)

Write a function

```haskell
dropZeros :: [Int] -> [Int]
```

that can be used to make our polynomials an instance of the type class `Eq`:

```haskell
instance (Eq IntPoly) where
  P xs == P ys = dropZeros xs == dropZeros ys
```
### Exercise 1.2 (🌶🌶)

Write a function

```haskell
polyToString :: [Int] -> String
```

that can be used to make our polynomials an instance of the type class `Show`:

```haskell
instance (Show IntPoly) where
  show (P xs) = polyToString xs
```


## Exercise 2

We want equip polynomials with algebraic operations.
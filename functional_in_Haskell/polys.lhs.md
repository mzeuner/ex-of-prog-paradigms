# Polynomials with integer coefficients

In this exercise session


## Exercise 1 (🌶)
Write functions

```haskell
polyToString :: [Int] -> String

dropZeros :: [Int] -> [Int]
```

that can be used to make our polynomials instances of the type classes `Eq` and `Show`:

```haskell
instance (Eq Poly) where
  P xs == P ys = dropZeros xs == dropZeros ys

instance (Show Poly) where
  show (P xs) = polyToString xs
```
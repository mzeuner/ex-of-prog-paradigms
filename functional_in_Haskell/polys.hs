import Test.QuickCheck

-- polynomials as lists (of integers) [Int]
-- addition and multiplication (and derivative)
-- polyToString :: [Int] -> String
-- [1,0,2] |-> x^2 + 1
-- dropZeroes [1,0,2,0,0] |-> [1,0,2]

addPoly :: [Int] -> [Int] -> [Int]
addPoly [] ys = ys
addPoly xs [] = xs
addPoly (x:xs) (y:ys) = (x + y) : addPoly xs ys

-- using zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
addPoly' :: [Int] -> [Int] -> [Int]
addPoly' xs ys = if length xs < length ys
  then zipWith (+) xs ys ++ drop (length xs) ys
  else zipWith (+) xs ys ++ drop (length ys) xs


mulPoly :: [Int] -> [Int] -> [Int]
mulPoly [] ys = []
mulPoly (x:xs) ys = addPoly (map (x*) ys) (0:mulPoly xs ys)


-- derivative
der :: [Int] -> [Int]
der [] = []
der xs = zipWith (*) (tail xs) [1..]

-- suboptimal but instructive
der' :: [Int] -> [Int]
der' xs = let n = length xs - 1
           in [ i * (xs !! i) | i <- [1..n] ]


-- turning polynomials into strings
monomialToString :: (Int , Int) -> String
monomialToString (0 , _) = ""
monomialToString (a , 0) = show a
monomialToString (a , 1) = show a ++ "x"
monomialToString (a , n) = show a ++ "x^" ++ show n

joinMonomial :: String -> String -> String
joinMonomial "" s = s
joinMonomial s "" = s
joinMonomial s s'
  | head s' == '-' = s ++ " - " ++ tail s'
  | otherwise = s ++ " + " ++ s'

polyToString :: [Int] -> String
polyToString [] = "0"
polyToString xs = foldr joinMonomial ""
                          (reverse $ map monomialToString (zip xs [0..]))

-- naive def. ignoring signs
-- polyToString xs = intersperse " + " (zipWith monomialToString (dropZeroes xs) [0..])


-- needed for equality
dropZeros :: [Int] -> [Int]
dropZeros xs = reverse $ dropWhile (==0) $ reverse xs

-- not needed for the course, but interesting to see how
-- equality and show work for custom data types
data Poly = P [Int]
instance (Eq Poly) where
  P xs == P ys = dropZeros xs == dropZeros ys
instance (Show Poly) where
  show (P xs) = polyToString xs

-- not needed for the course, but property-based testing
-- using quickcheck one of the coolest features of Haskell

-- let's test the multiplication rule for derivation
myTest :: [Int] -> [Int] -> Bool
myTest xs ys = P (der (mulPoly xs ys))
                 == P ((mulPoly xs (der ys)) `addPoly` (mulPoly (der xs) ys))

main :: IO ()
main = do
  let p = [2,0,1,-4,3]
  let q = [0,0,0]
  let r = mulPoly p p
  putStrLn $ show $ dropZeros p
  putStrLn $ show $ dropZeros q
  putStrLn $ show $ (P [0] == P [])
  putStrLn $ show $ der p
  putStrLn $ show r
  putStrLn $ show $ (P r)
  -- automated random testing
  quickCheck (withMaxSuccess 1000 myTest)

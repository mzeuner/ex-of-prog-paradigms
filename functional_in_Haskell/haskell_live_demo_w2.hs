-- polynomials as lists (of integers) [Int]
-- addition och multiplication (derivat)
-- polyToString [Int] -> String
-- [1,0,2] |-> 1 + x^2
-- dropZeroes [1,0,2,0,0] |-> [1,0,2]

addPoly :: [Int] -> [Int] -> [Int]
addPoly xs ys = if length xs < length ys
  then zipWith (+) xs ys ++ drop (length xs) ys
  else zipWith (+) xs ys ++ drop (length ys) xs
-- zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]

mulPoly :: [Int] -> [Int] -> [Int]
mulPoly [] ys = []
mulPoly (x:xs) ys = addPoly (map (x*) ys) (0:mulPoly xs ys)
-- map :: (a -> b) -> [a] -> [b]
-- foldr :: (a -> b -> b) -> b -> [a] -> b

der :: [Int] -> [Int]
der xs = zipWith (*) (tail xs) [1..]
-- drop 1 = tail
-- take 1 = \x -> [head x]

-- der xs = [ i * (xs !! i) | i <- [1..(length xs -1)] ]
      -- map (\i -> i * (xs !! i)) [1..(length xs -1)]

dropZeroes :: [Int] -> [Int]
dropZeroes xs = reverse $ dropWhile (==0) $ reverse xs

monomialToString :: Int -> Int -> String
monomialToString 0 _ = ""
monomialToString a 0 = show a
monomialToString a 1 = show a ++ "x"
monomialToString a i = show a ++ "x^" ++ show i

foo :: String -> String -> String
foo "" s = s
foo s "" = s
foo s s' = s++" + "++s'

intersperse

polyToString :: [Int] -> String
polyToString xs = foldr foo "" (zipWith monomialToString (dropZeroes xs) [0..])
                -- intersperse " + " (zipWith monomialToString (dropZeroes xs) [0..])
-- p := 2 + 2x^2
-- p' = 2x
-- q := -2 + x + x^4
-- q = 1 + 4x^3
{-
 mulPoly q p = -2 * (2 + x^2) + (x + x^4) * (2 + x^2)
             = -2 * (2 + x^2) + x * ((1 + x^3) * (2 + x^2))
                map (x*) ys      0:mulPoly xs ys

x^2 * x^4 = x ^ (2+4)
-}
p = [2, 0, 2,0,0]
q = [-2, 1, 0, 0, 1]
-- q = -2 : [1, 0,0,1]

main :: IO ()
main = do
  putStrLn $ show $ addPoly p $ q
  putStrLn $ show $ addPoly p p
  putStrLn $ show $ mulPoly p q
  putStrLn $ show $ der q
  putStrLn $ show $ dropZeroes p
  putStrLn $ polyToString p
  putStrLn $ polyToString q

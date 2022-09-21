
dropZerosAux :: Int -> [Int] -> [Int]
dropZerosAux n xs
  | length xs <= n = xs
  | otherwise = if all (0 ==) (drop n xs)
                   then take n xs
                   else dropZerosAux (n+1) xs

dropZeros :: [Int] -> [Int]
dropZeros xs = dropZerosAux 0 xs

addPoly :: [Int] -> [Int] -> [Int]
addPoly xs ys = let n = min (length xs) (length ys)
                 in zipWith (+) xs ys ++ drop n xs ++ drop n ys

mulPoly :: [Int] -> [Int] -> [Int]
mulPoly [] _ = []
mulPoly _ [] = []
mulPoly (x:xs) (y:ys) = (x*y) : addPoly (mulPoly xs (y:ys)) (mulPoly (x:xs) ys)

der :: [Int] -> [Int]
der xs = let n = length xs - 1
          in [ i * (xs !! i) | i <- [1..n] ]

p0 = [2,0,1,-4,3]
q0 = [0,0,0]

coeffToString :: (Int , Int) -> String
coeffToString (0 , _) = ""
coeffToString (a , 0) = show a
coeffToString (a , 1) = show a ++ "x"
coeffToString (a , n) = show a ++ "x^" ++ show n

joinCoeff :: String -> String -> String
joinCoeff "" s = s
joinCoeff s "" = s
joinCoeff s s'
  | [head s'] == "-" = s ++ "-" ++ tail s'
  | otherwise = s ++ "+" ++ s'

polyToString :: [Int] -> String
polyToString [] = "0"
polyToString xs = foldr joinCoeff ""
                          (reverse $ map coeffToString (zip xs [0..length xs-1]))

data Poly = P [Int]
instance (Eq Poly) where
  P xs == P ys = dropZeros xs == dropZeros ys
instance (Show Poly) where
  show (P xs) = polyToString xs

main :: IO ()
main = do
  putStrLn $ show $ dropZeros p0
  putStrLn $ show $ dropZeros q0
  putStrLn $ show $ (P [0] == P [])
  putStrLn $ show $ mulPoly p0 q0
  putStrLn $ show $ der p0
  let r = mulPoly p0 p0
  putStrLn $ show r
  putStrLn $ show $ (P r)

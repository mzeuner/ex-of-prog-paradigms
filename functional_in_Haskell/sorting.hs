
insertInSorted :: Int -> [Int] -> [Int]
insertInSorted x [] = [ x ]
insertInSorted x (y : xs) = if (x < y)
                              then x : y : xs
                              else y : insertInSorted x xs

insertionSort :: [Int] -> [Int]
insertionSort [] = []
insertionSort (x : xs) = insertInSorted x (insertionSort xs)


merge :: [Int] -> [Int] -> [Int]
merge xs [] = xs
merge [] ys = ys
merge (x : xs) (y : ys) = if (x < y)
                            then x : merge xs (y : ys)
                            else y : merge (x : xs) ys


mergeSort :: [Int] -> [Int]
mergeSort [] = []
mergeSort [ x ] = [ x ]
mergeSort xs = let n = length xs `div` 2
                   ys = take n xs
                   zs = drop n xs
  in merge (mergeSort ys) (mergeSort zs)

-- more list syntax
take' :: Int -> [a] -> [a]
take' n xs = [ xs !! i | i <- [0..n-1] ]


mylist = [ 12 , -3 , 27 , 2 , 3 , 1 , 9 ]

main :: IO ()
main = do
  putStrLn ("Sorting " ++ show mylist ++ " with insertion sort gives")
  let x = insertionSort mylist
  putStrLn $ show x
  putStrLn ("Sorting " ++ show mylist ++ " with merge sort gives")
  let y = mergeSort mylist
  putStrLn $ show y
  -- putStrLn (show (take 3 mylist) ++ "\n" ++ show (take' 3 mylist))

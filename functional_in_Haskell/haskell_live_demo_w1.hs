
insertInSorted :: Int -> [Int] -> [Int]
insertInSorted x [] = [ x ]
insertInSorted x (y : xs) = if (x < y)
                              then x : (y : xs)
                              else y : insertInSorted x xs


insertionSort :: [Int] -> [Int]
insertionSort [] = []
insertionSort (x : xs) = insertInSorted x (insertionSort xs)

{-
1 : [ 3 , 2 ] = [ 1 , 3 , 2 ]
[ 1 , 2 ] ++ [ 3 , 4 ] = [ 1 , 2 , 3 , 4 ]

insert 3 i [1 , 2 ]
1. är (3 < 1)? nej => resultatet är  [ 1 ] ++ insert 3 i [ 2 ]
2. är (3 < 2)? nej => resultatet är  [ 1 , 2 , ... ]
3. insert 3 i [] => resultatet är [ 1 , 2 , 3 ]
-}

{-
[4, 2, 3, 1] -> sortera [4,2] o. [3,1] -> merge [2,4] [1,3] -> [1,2,3,4]
-}

merge :: [Int] -> [Int] -> [Int]
merge [] [] = []
merge [] (y : ys) = (y : ys)
merge (x : xs) [] = (x : xs)
merge (x : xs) (y : ys) = if (x < y)
                            then x : merge xs (y : ys)
                            else y : merge (x : xs) ys

{-
merge [] ys = ys
merge xs [] = xs
merge (x : xs) (y : ys) = ...
-}

mergeSort :: [Int] -> [Int]
mergeSort [] = []
mergeSort [ x ] = [ x ]
mergeSort xs = merge (mergeSort ys) (mergeSort zs)
  where
    n = (length xs) `div` 2
    ys = take n xs
    zs = drop n xs
    -- xs = ys ++ zs

{-
xs = [ x ] -> ys = [] , zs = [ x ]
-}

mylist = [ 12 , -3 , 27 , 2 , 3 , 1 , 9 ]
h1 = [-3 , 1 , 2 , 3 ]
h2 = [ 9 , 12 , 27 ]

main :: IO ()
main = do
  -- putStrLn (show (insertionSort mylist))
  putStrLn (show (mergeSort mylist))
  -- putStrLn (show (merge h1 h2))

{-
show insertionSort mylist = (show insertionSort) mylist
-}

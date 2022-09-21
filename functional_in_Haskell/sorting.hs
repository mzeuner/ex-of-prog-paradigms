import Test.QuickCheck

-- First, we implement insertion sort
insertInSorted :: Ord a => a -> [a] -> [a]
insertInSorted x [] = [ x ]
insertInSorted x (y : xs) = if (x < y)
                               then x : y : xs
                               else y : insertInSorted x xs

insertionSort :: Ord a => [a] -> [a]
insertionSort [] = []
insertionSort (x : xs) = insertInSorted x (insertionSort xs)


-- Second, an implementation of merge sort
merge :: Ord a => [a] -> [a] -> [a]
merge xs [] = xs
merge [] ys = ys
merge (x : xs) (y : ys) = if (x < y)
                             then x : merge xs (y : ys)
                             else y : merge (x : xs) ys

mergeSort :: Ord a => [a] -> [a]
mergeSort [] = []
mergeSort [ x ] = [ x ]
mergeSort xs = let n = length xs `div` 2
                   -- this is the same as: div (length xs) 2
                   ys = take n xs
                   zs = drop n xs
               in merge (mergeSort ys) (mergeSort zs)


-- Let's test our two sorting functions
-- This is in Data.List.Order but a fun exercise
isSorted :: Ord a => [a] -> Bool
isSorted [] = True
isSorted [x] = True
isSorted (x:y:xs) = (x <= y) && isSorted (y:xs)

testSorted :: [Int] -> Bool
testSorted xs = isSorted (mergeSort xs) && (mergeSort xs == insertionSort xs)

main :: IO ()
main = do
  let mylist = [ 12 , -3 , 27 , 2 , 3 , 1 , 9 ]
  putStrLn ("Sorting " ++ show mylist ++ " with insertion sort gives")
  let x = insertionSort mylist
  putStrLn $ show x
  putStrLn ("Sorting " ++ show mylist ++ " with merge sort gives")
  let y = mergeSort mylist
  putStrLn $ show y

  -- automated random testing
  quickCheck (withMaxSuccess 1000 testSorted)

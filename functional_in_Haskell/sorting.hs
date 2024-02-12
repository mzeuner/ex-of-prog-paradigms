import Test.QuickCheck

-- insertion sort
insertInSorted :: Ord a => a -> [a] -> [a]
insertInSorted x [] = [ x ]
insertInSorted x (y : xs) = if (x < y)
                               then x : y : xs
                               else y : insertInSorted x xs

insertionSort :: Ord a => [a] -> [a]
insertionSort [] = []
insertionSort (x : xs) = insertInSorted x (insertionSort xs)


-- merge sort
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


-- bubble sort
bubble :: Ord a => [a] -> [a]
bubble [] = []
bubble [x] = [x]
bubble (x:y:xs) = if (x < y)
                     then x: bubble (y:xs)
                     else y: bubble (x:xs)

bubbleSort :: Ord a => [a] -> [a]
bubbleSort [] = []
bubbleSort xs = let ys = bubble xs
                in bubbleSort (init ys) ++ [last ys]


-- Let's test our sorting functions
testSorted :: [Int] -> Bool
testSorted xs = (mergeSort xs == insertionSort xs) && (mergeSort xs == bubbleSort xs)

main :: IO ()
main = do
  let mylist = [ 12 , -3 , 27 , 2 , 3 , 1 , 9 ]
  putStrLn ("Sorting " ++ show mylist ++ " with insertion sort gives")
  let x = insertionSort mylist
  putStrLn $ show x
  putStrLn ("Sorting " ++ show mylist ++ " with merge sort gives")
  let y = mergeSort mylist
  putStrLn $ show y
  putStrLn ("Sorting " ++ show mylist ++ " with bubble sort gives")
  let z = bubbleSort mylist
  putStrLn $ show z

  -- automated random testing
  quickCheck (withMaxSuccess 1000 testSorted)

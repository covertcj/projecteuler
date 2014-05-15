mergeLists :: (Ord a) => [a] -> [a] -> [a]
mergeLists xall@(x:xs) yall@(y:ys) =
    case compare x y of
        LT -> x : (mergeLists xs   yall)
        EQ -> x : (mergeLists xs   ys)
        GT -> y : (mergeLists xall ys)

diffList :: (Ord a) => [a] -> [a] -> [a]
diffList xall@(x:xs) yall@(y:ys) =
    case compare x y of
        LT -> x : (diffList xs   yall)
        EQ -> diffList xs   ys
        GT -> diffList xall ys

nonprimes :: [Integer]
nonprimes = foldr1 mergeMultiples $ map genMultiples $ tail primes
    where mergeMultiples (x:xs) ys  = x : (mergeLists xs ys)
          genMultiples p            = [ n * p | n <- [p , p + 2 ..]]

primes :: [Integer]
primes = [2, 3, 5] ++ (diffList [7, 9 ..] nonprimes)

main :: IO ()
main = do
    print $ primes !! 1001

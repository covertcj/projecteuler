-- A recursive helper method for factorsOf
factorsOfR :: Integer -> Integer -> [Integer] -> [Integer]
factorsOfR remain divisor ls
    | remain == 1 = ls

    | (rem remain divisor) == 0 =
        let remain' = div remain divisor
            ls'     = divisor : ls
        in factorsOfR remain' divisor ls'

    | otherwise = factorsOfR remain (divisor + 1) ls

-- Calculates the primes factors of a given number.
factorsOf :: Integer -> [Integer]
factorsOf n = factorsOfR n 2 []

-- Calculates the prime factors of each number from 1 to n.
factorsUpTo :: Integer -> [[Integer]]
factorsUpTo 1 = [[1]]
factorsUpTo n = (factorsOf n) : (factorsUpTo n')
    where n' = n - 1

-- Counts the number of duplicates of a given number in the given list.
countDupes :: Integer -> [Integer] -> Integer
countDupes n ls = foldl (\acc x -> if x == n then acc + 1 else acc) 0 ls

-- An implementation of union that allows duplicates of the same number.  If
-- there are duplicates, the resulting list has x of that number where x is
-- the larger number of duplicates between the lists
unionDupes :: [Integer] -> [Integer] -> [Integer]
unionDupes [] ys = ys
unionDupes (x:xs) ys = toAdd ++ (unionDupes xs' ys')
    where xdupes = countDupes x (x:xs)
          ydupes = countDupes x ys
          dupes  = max xdupes ydupes
          toAdd  = take (fromIntegral dupes) (repeat x)
          xs'    = filter (\n -> n /= x) xs
          ys'    = filter (\y -> y /= x) ys

-- Unions together each list in a list of lists.
unionAll :: [[Integer]] -> [Integer]
unionAll ls = foldl (\acc x -> unionDupes acc x) [] ls

-- Gets the prime factors of each number 1 through n, unions them (without
-- uniqueness), and takes the product of the resulting list.
lowestEvenlyDivisible :: Integer -> Integer
lowestEvenlyDivisible n = product factors
    where factors = unionAll $ factorsUpTo n

main :: IO ()
main = do
    print $ lowestEvenlyDivisible 10
    print $ lowestEvenlyDivisible 20

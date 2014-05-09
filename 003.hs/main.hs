factorsOfR :: Integer -> Integer -> [Integer] -> [Integer]
factorsOfR remain divisor ls
    | remain == 1 = ls

    | (rem remain divisor) == 0 =
        let remain' = div remain divisor
            ls'     = divisor : ls
        in factorsOfR remain' divisor ls'

    | otherwise = factorsOfR remain (divisor + 1) ls

factorsOf :: Integer -> [Integer]
factorsOf n = factorsOfR n 2 []

main :: IO ()
main = do
    print $ factorsOf 23
    print $ factorsOf 29
    print $ factorsOf 13195
    print $ factorsOf 600851475143
    print $ factorsOf 232792560

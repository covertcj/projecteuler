sumOfSquares :: Integer -> Integer
sumOfSquares 1 = 1
sumOfSquares n = (n * n) + sumOfSquares (n - 1)

squareOfSumsR :: Integer -> Integer -> Integer
squareOfSumsR 0 acc = acc * acc
squareOfSumsR n acc = squareOfSumsR n' acc'
    where acc' = acc + n
          n' = n - 1

squareOfSums :: Integer -> Integer
squareOfSums n = squareOfSumsR n 0

sosDifference n = y - x
    where x = sumOfSquares n
          y = squareOfSums n
    

main :: IO ()
main = do print $ sosDifference 100

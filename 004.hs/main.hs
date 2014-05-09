--------------------------------------------------------------------------------
-- Project Euler #4
--
-- Problem:
--   A palindromic number reads the same both ways. The largest palindrome
--   made from the product of two 2-digit numbers is 9009 = 91 × 99.
--
--   Find the largest palindrome made from the product of two 3-digit numbers.
-- 
-- Solution:
--------------------------------------------------------------------------------

highestNumberWithDigits :: Integer -> Integer
highestNumberWithDigits n = read strFactor::Integer
    where strFactor = take (fromIntegral n) (repeat '9')

-- Finds the highest number that can be obtained by multiplying two numbers
-- with n digits.
highestProductForDigits :: Integer -> Integer
highestProductForDigits n = factor * factor
    where factor = highestNumberWithDigits n

-- Checks to see if the given number is a palindrome.
checkPalindrome :: Integer -> Bool
checkPalindrome n = nChars == nCharsReverse
    where nChars = show n
          nCharsReverse = reverse nChars

-- Finds the first palindrome lower than n.
nextPalindrome :: Integer -> Integer
nextPalindrome n = if checkPalindrome n' then n' else nextPalindrome n'
    where n'      = n - 1
          n'Chars = fromIntegral n'

countDigits :: Integer -> Integer
countDigits n = fromIntegral $ length (show n)

-- Recursive helper for checkProductOfDigits.
checkProductOfDigitsR :: Integer -> Integer -> Integer -> Bool
checkProductOfDigitsR n numDigits cur
    | curDigits /= numDigits = False
    | r == 0 = if countDigits (div n cur) == numDigits
                   then True
                   else checkProductOfDigitsR n numDigits (cur - 1)
    | otherwise = checkProductOfDigitsR n numDigits (cur - 1)
    where curDigits = countDigits cur
          r         = rem n cur

-- Checks if the given number can be factored into two numbers with n digits.
checkProductOfDigits :: Integer -> Integer -> Bool
checkProductOfDigits n numDigits = checkProductOfDigitsR n numDigits highest
    where highest = highestNumberWithDigits numDigits

-- Helper for highestPalindromeForDigits.
highestPalindromeForDigitsR :: Integer -> Integer -> Integer
highestPalindromeForDigitsR 1 _ = -1
highestPalindromeForDigitsR n numDigits =
    if checkProductOfDigits n numDigits
        then n
        else highestPalindromeForDigitsR (nextPalindrome n) numDigits

-- Finds the largest palindrome made from the product of two numbers with n
-- digits.
highestPalindromeForDigits :: Integer -> Integer
highestPalindromeForDigits n = highestPalindromeForDigitsR start n
    where start = nextPalindrome $ (highestProductForDigits n) + 1

main :: IO ()
main = do
    print $ highestPalindromeForDigits 2
    print $ highestPalindromeForDigits 3

doubleMe x = x + x

doubleUs x y = doubleMe x + doubleMe y

doubleSmallNumber x = if x > 100
    then x
    else doubleMe x

doubleSmallNumber' x = (if x > 100 then x else doubleMe x) + 1

boomBang xs = [if even x then "BOOM!" else "BANG!" | x <- xs, x > 10 ]
primeNumbers = [2,3,5,7,11,13]
boomBang' xs = [if even x then "BOOM!" else "BANG!" | x <- xs, x > 10, x `elem` primeNumbers] 

length' xs = sum [1 | _ <- xs]

removeNonUppercase :: String -> String
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]   

addThree :: Int -> Int -> Int -> Int
addThree a b c = a+b+c

factorial :: Integer -> Integer
factorial n = product [1..n]

circumference :: Float -> Float
circumference r = 2 * r * pi

circumference' :: Double -> Double
circumference' r = 2 * r * pi

lucky :: (Integral a) => a -> String
lucky 7 = "LUCKY NUMBER 7"
lucky x = "Try again pal!"

factorial' :: (Integral a) => a -> a
factorial' 0 = 1
factorial' n = n * factorial' (n - 1)

charName :: Char -> String
charName 'a' = "Albert"
charName 'b' = "Bernoulli"
charName 'c' = "Curie"
charName x = "Don't know the bum"

addVectors :: (Num a) => (a,a) -> (a,a) -> (a,a)
addVectors (x1,y1) (x2,y2) = (x1 + x2, y1 + y2)

first :: (Num a) => (a,a,a) -> a
first (x,_,_) = x

head' :: [a] -> a
head' [] = error "The list is empty"
head' (x:_) = x

tell :: (Show a) => [a] -> String
tell [] = "The list is empty"
tell (x:[]) = "The list contains one element: " ++ show x
tell (x:y:[]) = "The list contains two elements: " ++ show x ++ " and " ++ show y
tell (x:y:_) = "The list is long, the first two elements are " ++ show x ++ " and " ++ show y

length'' :: (Num a) => [a] -> a
length'' [] = 0
length'' (_:xs) = 1 + length'' xs

sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs

capital :: String -> String
capital "" = "The string is empty"
capital all@(x:_) = "The first letter of " ++ all ++ " is " ++ [x]

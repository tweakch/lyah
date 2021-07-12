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

bmiTell :: (RealFloat a) => a -> a -> String 
bmiTell weight height
    | bmi <= skinny = "You are an anorexic mess! Eat some sugar or the wind will blow you away!"
    | bmi <= normal = "You're supposedly Normal. Pffft, I bet you're ugly!"
    | bmi <= fat = "Ay fatty boom-boom! Ay fatty boom-boom"
    | otherwise   = "You are a whale! Congratulations"
    where bmi = weight / height ^ 2
          (skinny, normal, fat) = (18.5,20.5,30.0)

initials :: String -> String -> String
initials firstname lastname = [f] ++ ". " ++ [l] ++ "."
    where (f:_) = firstname
          (l:_) = lastname
          
cylinder :: (RealFloat a) => a -> a -> a
cylinder r h = 
    let sideArea = 2 * pi * r * h
        topArea  = pi * r^2
    in  sideArea + 2 * topArea

perimeter :: (Num a) => [a] -> a
perimeter [] = 0
perimeter (x:xs) = x + perimeter xs

cube :: (Num a) => a -> a -> a -> a
cube w l h = 
    let sideArea  = w * h
        topArea   = w * l
        frontArea = l * h 
    in  2 * (sideArea + topArea + frontArea)

cube' :: (Num a) => a -> a -> a -> a
cube' width length height = 2 * (side + front + top)
    where side  = width * length
          top   = width * height
          front = height * length 

describeList :: [a] -> String  
describeList xs = "The list is " ++ case xs of [] -> "empty."  
                                               [x] -> "a singleton list."
                                               xs -> "a longer list."  
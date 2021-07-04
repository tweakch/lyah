# Types and Typeclasses

## Types

Haskell has a *static type system* meaning the type of an expression is known *at compile time*.

Everything in Haskell is an expression so *everything in Haskell has a type*.

Haskell has *type inference* so if the compiler is able to figure out the type of an expression it will compile.

We can look at the type of an expression using `:t` command.

```hs
ghci> :t 'a'
'a' :: Char
ghci> :t True
True :: Bool
ghci> :t "Hello you!"
"Hello you!" :: String
ghci> :t (True, 'a') 
(True, 'a') :: (Bool, Char)
ghci> :t 4 == 5
4 == 5 :: Bool
```

Functions also have types. Lets define a function that removes all non-uppercase letters from a list of characters.

```hs
removeNonUppercase :: [Char] -> [Char]  
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]
```

`removeNonUppercase` has a type of `[Char] -> [Char]`, meaning it takes one string as a parameter and returns another as result. The last `[Char]` type is synonymous to `String` so it's cleaner if we update the type of the function to `[String] -> [String]`.

```hs
ghci> :t removeNonUppercase
removeNonUppercase :: String -> String
```

Let's write a function that adds three `Int`:

```hs
addThree :: Int -> Int -> Int -> Int
addThree a b c = a + b + c
```

```hs
ghci> addThree 1 2 3
6
```

`Int` on a 32-bit system is 2147483647 and -2147483648.

`Integer` stands for unbounded integrals.

```hs
factorial :: Integer -> Integer
factorial n = product [1..n]
```

```hs
ghci> factorial 40
815915283247897734345611269596115894272000000000
```

`Float` is a real floating point with single precision.

```hs
circumference :: Float -> Float
circumference r = 2 * r * pi
```

```hs
ghci> circumference 4.0
25.132742
ghci> circumference 4 --type inference!
25.132742
```

`Double` is a real floating point with ***double*** the precision!

```hs
circumference' :: Double -> Double
circumference' r = 2 * r * pi
```

```hs
ghci> circumference' 4.0
25.132741228718345
ghci> circumference' 4 --type inference!
25.132741228718345
```

`Bool` is a boolean type. It can have two values `True` and `False`

`Char` represents a single character. A list of characters `[Char]` represents a string of type `String`.

Tuples are types dependent on their length as well as the types of their components, so there are an *infitite* amount of tuple-types. The empty tuple `()` is also a type which can only have a single value `()`.

```hs
ghci> :t ()
() :: ()
```

## Type variables

What is the type of the `fst` function? It takes a tuple and returns the first value of it. But this can be any type, how is that function's type declaration?

```hs
ghci> :t fst
fst :: (a, b) -> a
```

`a` and `b` are so called **type variables**. They are like the typenames in C# generics but can be of any type.

Functions that have type variables are called **polymorphic functions**. The type declaration of `fst` states that it takes a tuple of any two types and returns one element of the first type in the tuple. `a` and `b` don't have to be different. They can have the same type but the function will always return a value with type `a`.

## Typeclasses

Remember where we analyzed the type of a list of lists?

```hs
ghci> :t [[1,2],[2,3]]
[[1,2],[2,3]] :: Num a => [[a]]
```

There is a symbol `=>` in the declaration. Everything before that is called a *class constraint*.

This constrains the `a` type variable to only allow `Num` for values `a`.

```hs
ghci> :t (==)
(==) :: Eq a => a -> a -> Bool
```

`Eq` is used for types that implement equality testing. Meaning `==` and `/=` are used somewhere inside the definiton.

`Ord` is used for types that can return an ordering. `>`, `<`, `>=`, `<=`.

```hs
ghci> :t (<)
(<) :: Ord a => a -> a -> Bool
```

`Ordering` is a type that can be GT, LT or EQ.

```hs
ghci> :t compare
compare :: Ord a => a -> a -> Ordering

ghci> 5 `compare` 4
GT
```

`Show` turns a value of any type into a string

```hs
ghci> :t show
show :: Show a => a -> String

ghci> show True
"True"
```

`Read` does the opposite of `Show`.

```hs
ghci> :t read
read :: Read a => String -> a
```

If the compiler can not infer the type of `a` out of context, it needs to be instructed about the type!

```hs
ghci> read "True"
*** Exception: Prelude.read: no parse
True
ghci> read "True" :: Bool
True
read "(3, 'a')" :: (Int, Char)  
(3, 'a')
```

`Enum` members can be enumerated. The main advantage is that we can use its types in list ranged. They also have defined *successors* and *predecessors* which can be queried using `succ` and `pred` functions. Types in this class are `()`, `Bool`, `Char`, `Ordering`, `Int`, `Integer`, `Float` and `Double`.

```hs
ghci> ['a'..'e']  
"abcde"  
ghci> [LT .. GT]  
[LT,EQ,GT]  
ghci> [3 .. 5]  
[3,4,5]  
ghci> succ 'B'  
'C' 
```

`Bounded` members have an upper and a lower bound.

```hs
ghci> :t minBound
minBound :: Bounded a => a
ghci> minBound :: Int  
-2147483648  

ghci> :t maxBound
maxBound :: Bounded a => a
ghci> maxBound :: Char  
'\1114111'  

ghci> maxBound :: Bool  
True  
ghci> minBound :: Bool  
False  
```

`Num` is a numeric typeclass. Its members can act like numbers.

`Integral` includes integral (whole) numbers. In this typeclass are `Int` and `Integer`. Not the same as `Num` which also includes real numbers.

`Floating` includes only floating point numbers, so `Float` and `Double`.

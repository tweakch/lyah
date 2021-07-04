# Syntax in functions

## Pattern matching

Pattern consits of specifying patterns to which some data should conform and then checking to see if it does and deconstruncting the data according to those patterns.

Whew! What this means is that we can write a function like this:

```hs
lucky :: (Integral a) => a -> String
lucky 7 = "LUCKY NUMBER 7"
lucky x = "Try again pal!"
```

```hs
ghci> lucky 8
"Try again pal!"
ghci> lucky 7
"LUCKY NUMBER 7"
```

This will try to match our calling pattern `lucky 8` which will not match on the first pattern `lucky 7`, drop through and try the next pattern. `lucky x` will match anything and bind to `x`.

Pattern matching can also fail:

```hs
charName :: Char -> String
charName 'a' = "Albert"
charName 'b' = "Bernoulli"
charName 'c' = "Curie"
```

```hs
ghci> charName 'a'
"Albert"
ghci> charName 'b'
"Bernoulli"
ghci> charName 'c' 
"Curie"
ghci> charName 'd'
"*** Exception: functions.hs:(41,1)-(43,22): Non-exhaustive patterns in function charName
```

By adding `charName x = "Don't know"` to the bottom of our function we can stop this error from occurring.

```hs
ghci> charName 'd'
"Don't know"
```

In the previous chapter we defined `factorial n = product [1..n]`

This can be rewritten as a recursive function `factorial'`.

```hs
factorial' :: (Integral a) => a -> a
factorial' 0 = 1
factorial' n = n * factorial' (n - 1)
```

### Pattern matching with tuples

The following function will add two vectors together and return a new one.

```hs
addVectors :: (Num a) => (a,a) -> (a,a) -> (a,a)
addVectors a b = (fst a + fst b, snd a snd b)
```

We use `fst` and `snd` to access the components of `a` and `b`. This can also be done with pattern matching.

```hs
addVectors :: (Num a) => (a,a) -> (a,a) -> (a,a)
addVectors (x1,y1) (x2,y2) = (x1 + x2, y1 + y2)
```

### Pattern matching with triples

For triples we could write three functions to easily access their components.

```hs
first :: (Num a) => (a,a,a) -> a
first (x,_,_) = x

second :: (Num a) => (a,a,a) -> a
second (_,y,_) = y

thrid :: (Num a) => (a,a,a) -> a
third (_,_,z) = z
```

> Note: The `_` means the same thing as in [list comprehensions](02-starting-out#count-elements)

### Pattern matching with list comprehensions

Pattern matching also works for list comprehensions.

```hs
ghci> let xs = [(1,2),(2,3),(3,4)]
ghci> [a+b | (a,b) <- xs]
[3,5,7]
```

### Pattern matching with lists

Lists can also be used in pattern matching.

> Note: `x:xs` will match the head of the list to `x` and the tail of the list to `xs` even if the list only contains one element.

To bind the first three elements to variables and the rest to another variable we can use `x:y:z:zs`.

Applied to a function:

```hs
head' :: [a] -> a
head' [] = error "The list is empty"
head' (x:_) = x
```

> Note: If we want to bind to multiple variables (even if one is `_`) we have to surround them with parentheses.

```hs
tell :: (Show a) => [a] -> String
tell [] = "The list is empty"
tell (x:[]) = "The list contains one element: " ++ show x
tell (x:y:[]) = "The list contains two elements: " ++ show x ++ " and " ++ show y
tell (x:y:_) = "The list is long, the first two elements are " ++ show x ++ " and " ++ show y
```

This function takes care of all possibilities and is therefore considered safe. Note we could rewrite `(x:[])` and `([x:y:[]])` with `[x]` and `[x,y]` because it's syntactic sugar and we don't need the parentheses.

We can rewrite our `length'` function using recursion and pattern matching.

```hs
length'' :: (Num a) => [a] -> a
length'' [] = 0
length'' (_:xs) = 1 + length'' xs
```

The following function uses pattern matching to sum over a list of numbers:

```hs
sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs
```

### as patterns

When breaking up stuff according a pattern we can retain a reference to the thing we've broken up by using `anything@` before our pattern. 

Like that we can use `anything` in our function as well as our pattern match components.

```hs
capital :: String -> String
capital "" = "The string is empty"
capital all@(x:_) = "The first letter of " ++ all ++ " is " ++ [x]
```

> Note: When returning `x` in our string we need to put it in `[]`. If we don't the compiler will complain because he tries to `++` a `Char x` to a `[Char]`.

```hs
functions.hs:72:64: error:
    * Couldn't match expected type `[Char]' with actual type `Char'
```

## Guards

## Where

## Let .. in

## Case expressions

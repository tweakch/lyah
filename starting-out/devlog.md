# Starting out



```hs
ghci> True
True

ghci> not True
False

ghci> 2.5*2
5.0

ghci> 2.5*2
5.0
```

## Functions

> `*` is a function that takes two numbers and multiplies them.

Functions in haskell use `Spaces` for function application. Function application has the highest precedence of them all. That means the following statements are equivalent

```hs
ghci> succ 9 + max 5 4 + 1  
16 

ghci> (succ 9) + (max 5 4) + 1  
16 
```

### Infix functions

if a function takes two arguments, we can call it as an `infix function` by surrounding it with backticks:

```hs
ghci> div 9 3
3
ghci> 9 `div` 3
3
```

## First functions

Functions are `defined` in a similar way that they are `called`.

Create a new file in `starting-out\baby.hs` and add the following line to it.

```hs
doubleMe x = x + x
```

Load the function using `:l baby`

```hs
ghci> :l baby
target `baby' is not a module name or a source file
```

> The error message is caused because `ghci` does not run in the same folder as `baby.hs`.

Quit ghci using `:q` and switch into the `starting-out` folder.

```ps
ghci> :q
Leaving GHCi.
PS> cd .\starting-out\
PS> ghci
```

```hs
GHCi, version 9.0.1: https://www.haskell.org/ghc/  :? for help
ghci> :l baby
[1 of 1] Compiling Main             ( baby.hs, interpreted )
Ok, one module loaded.
```

Append a new function to `baby.hs`:

```hs
doubleUs x y = x*2 + y*2
```

Save and reload `baby.hs` using either `:l baby` or `:r`

```hs
ghci> doubleUs 5 3    
16

ghci> doubleUs 28 88 + doubleMe 123 
478
```

Instead of using `*` in `doubleUs` to multiply by two, we can use our own `doubleMe` function.

```hs
doubleUs x y = doubleMe x + doubleMe y
```

We define a function with logic: 

```hs
doubleSmallNumber x = if x > 100
    then x
    else doubleMe x
```

We can modify our `doubleSmallNumber` function and make it add `1` to every number it doubles for us.  

```hs
doubleSmallNumber' x = (if x > 100 then x else doubleMe x) + 1
```

> The `'` character is often to denote adjusted versions of functions

## Lists

Lists are **homogenous** datastructures. 

```hs
ghci> let primes = [2,3,5,7,11,13]
ghci> primes
[2,3,5,7,11,13]
```

> **Note:** Doing `let a = 1` inside GHCI is equivalent to writing `a = 1` in a script and then loading it.

### ++ operator

We can concat two lists using the `++` operator. 

```hs
ghci> [2,3]++[3,4]
[2,3,3,4]
ghci> "hello" ++ " " ++ "world"
"hello world"
```

> **NOTE** Haskell has to iterate over every element in the second list to add it to the first list. This can take a long time when the second list is huge. However using the `cons` operator is instantaneous. 

### cons operator

```hs
ghci> 'A' : " SMALL WORLD"
"A SMALL WORLD"
ghci> 17:primes
[17,2,3,5,7,11,13]
```

> **NOTE** how `:` takes a character and a list of characters or a number and a list of number, whereas `++` takes two lists. So adding a `single element` to a list using `++` the element has to be surrounded by `[]`

`[1,2,3]` is syntactic sugar for `1:2:3:[]`

### Get by index

```hs
ghci> primes !! 2
5
```

### Basic functions

Some basic functions that operate on lists

```hs
ghci> head primes
2
ghci> last primes
13
ghci> tail primes
[3,5,7,11,13]
ghci> init primes
[2,3,5,7,11]
ghci> length primes
6
ghci> null primes
False
ghci> null []    
True
ghci> reverse primes
[13,11,7,5,3,2]
ghci> take 2 primes
[2,3]
ghci> take 0 primes
[]
ghci> maximum primes
13
ghci> minimum primes
2
ghci> sum primes
41
ghci> product primes
30030
ghci> 3 `elem` primes
False
ghci> 7 `elem` primes
True
```

## Ranges

```hs
ghci> [1..10]
[1,2,3,4,5,6,7,8,9,10]
ghci> ['a'..'z']
"abcdefghijklmnopqrstuvwxyz"
```

### Steps

```hs
ghci> [2,4..20]
[2,4,6,8,10,12,14,16,18,20]
ghci> [3,6..20]
[3,6,9,12,15,18]
ghci> ['a','c'..'z']
"acegikmoqsuwy"
```

### Infinite Lists

By not defining an upper bound we can create infitie lists f.e. `[2,4..]`.

By combining this with the `take` function we can get the first twenty even numbers very easily.

```hs
ghci> take 20 [2,4..]
[2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40]
```

You can also annoy your CPU with this.

```hs
ghci> reverse [2,4..]
Interrupted.
ghci> ::[2,4..]
```

There are other functions that produce infinite lists:

```hs
ghci> take 10 (cycle primes) 
[2,3,5,7,11,13,2,3,5,7]
ghci> take 12 (cycle "lol ")
"lol lol lol "
ghci> take 3 (repeat 10)  
[10,10,10]
ghci> replicate 3 10 
[10,10,10]
```

### Comprehensions and filtering

Duplicate numbers 1-10 by two

```hs
ghci> [x*2 | x <- [1..10]]
[2,4,6,8,10,12,14,16,18,20]
```

...but only if x+x is bigger than 10

```hs
ghci> [x*2 | x <- [1..10], x*2>10]
[12,14,16,18,20]
```

All numbers from 1-100 that when divided by 7 get a remainder of 2

```hs
ghci> [x | x <- [1..100], x `mod` 7 == 2]  
[2,9,16,23,30,37,44,51,58,65,72,79,86,93,100]
```

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

Special character functions `*`, `+`, `-`, `/`, `==`, `/=`, `>`, `<`, `>=`, `<=`, `&&`, `||`, `++`, `--`, `!!` are implicit infixes.

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

The last part of the comprehension is the predicate. Using predicates is also called **filtering**.

Let's now generate a list of `BOOM!` for even numbers and `BANG!` for odd numbers for all numbers bigger than 10.

```hs
boomBang xs = [ if even x then "BOOM!" else "BANG!" | x <- xs, x > 10]
```

`x > 10` is our predicate and only returns `True` for numbers bigger than 10.
The output function checks for *evenness* and returns `BOOM!` otherwise `BANG!`.

```hs
ghci> boomBang [1..14]
["BOOM!","BANG!","BOOM!","BANG!"]
```

#### Multiple predicates

We can add more than one predicate to include all primes from 1-10. (an element must satisfy all the predicates to be included in the resulting list)

```hs
primeNumbers = [2,3,5,7,11,13,17]
boomBang' xs = [if even x then "BOOM!" else "BANG!" | x <- xs, x > 10, x `elem` primeNumbers] 
```

With this we can have some fun using the `cons` to create some awesome song lyrics:

```hs
ghci> "He shot me down..." : boomBang' [1..14]
["He shot me down...","BANG!","BANG!"]
```

#### Multiple lists

We can have more than one list to draw from and only output the value if the result matches the predicate.

```hs
ghci> [x*y | x <- [2,3,4], y <- [3,4,5], x*y > 10]
[12,15,12,16,20]
```

This also works with lists of strings 

```hs
ghci> let a = ["awesome", "stinky", "hilarious"] 
ghci> let n = ["teacher","officer", "hero"]                    
ghci> [ad ++ " " ++ no | ad <- a, no <- n] 
["awesome teacher","awesome officer","awesome hero","stinky teacher","stinky officer","stinky hero","hilarious teacher","hilarious officer","hilarious hero"]
```

##### Count elements

For a real world example, lets count the numbers of elements in our `primeNumbers` list:

```hs
ghci> let length' xs = sum [ 1 | _ <- xs]
ghci> length' primeNumbers
6
```

> Note: The `_` means that we dont care what we pull from `xs` and throw it away.

And because strings are lists, we can now count the length of strings with this: 

```hs
ghci> l' "how long is this?"  
17
```

Accurate.

## Tuples

Tuples are like lists but they are denoted with parentheses.

Tuples of size two are called pairs. `(1,2)`

Tuples of size three are called triples. `(1,2,3)`

```hs

```

As with vectors `[1,2]` we can add tuples to lists.

```hs
[(1,2),(3,4)]
```

Other than in lists, we can't do this:

```hs
ghci> [(1,2),(1,2,3),(1,2)]

<interactive>:161:8: error:
    * Couldn't match expected type: (a, b)
                  with actual type: (a0, b0, c0)
    * In the expression: (1, 2, 3)
      In the expression: [(1, 2), (1, 2, 3), (1, 2)]
      In an equation for `it': it = [(1, 2), (1, 2, 3), (1, 2)]
    * Relevant bindings include
        it :: [(a, b)] (bound at <interactive>:161:1)
```

Tuples don't have to be homogeneous:

```hs
ghci> (1,"2")
(1,"2")
```

Lists do:

```hs
ghci> [1,"2"]

<interactive>:163:2: error:
    * No instance for (Num String) arising from the literal `1'
    * In the expression: 1
      In the expression: [1, "2"]
      In an equation for `it': it = [1, "2"]
```

To understand why we can look at the type of an expression using the `:t` prefix.

```hs
ghci> :t [[1,2],[2,3]]
[[1,2],[2,3]] :: Num a => [[a]]
ghci> :t [[1,2],[1,2,3],[2,3]]
[[1,2],[1,2,3],[2,3]] :: Num a => [[a]]
ghci> :t [(1,2),(2,3)] 
[(1,2),(2,3)] :: (Num a, Num b) => [(a, b)]
ghci> :t [(1,"one"),(2,"two")] 
[(1,"one"),(2,"two")] :: Num a => [(a, String)]
```

So a list of vectors is just a list of numbers... whereas a list of tuples is a list of types. As seen in the last example (`"one"` and `"two"` being lists of characters), tuples can also contain lists.

### Right Triangle Example

Lets finish this chapter by finding the smallest right triangle with integer side-length.

To create a list of all triangles with side lengths between 1 and 10 we can do this.

```hs
[(a,b,c) | c <- [1..10], b <-[1..10],a<-[1..10]]
```

Our solution will be in this set of triples.

Now lets add a condition that only right triangles are allowed (we remove duplicates by restricting the b isn't larger than the hypothenuse and side a isn't larger than side b)

```hs
ghci> [(a,b,c) | c <- [1..10], b <-[1..c], a<-[1..b], a^2 + b^2 == c^2]
[(3,4,5),(6,8,10)]
```

Now we can add a final condition by filtering triangles with  only allowing triangles with perimeter 12.

```hs
ghci> let rightTriangles = [(a,b,c) | c <- [1..10], b <-[1..c],a<-[1..b], a^2 + b^2 == c^2, a+b+c==12]
ghci> rightTriangles
[(3,4,5)]
```

***This is a common pattern in functional programming:*** Take a starting set of solutions and apply transformations to those solutions and filter them until you get the right ones.

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

This function takes care of all possibilities and is therefore considered safe. Note we should rewrite `(x:[])` and `([x:y:[]])` with `[x]` and `[x,y]` because it's syntactic sugar - we like sugar - and we don't need the parentheses.

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

## Guards and where bindings

Guards are a way to test if a property of a value - or multiple properties - are true or false. 

Let's create a function that caluclates our body mass index (bmi) and tells us off depending on our weight. 

```hs
bmiTell :: (RealFloat a) => a -> a -> String 
bmiTell weight height
    | bmi <= skinny = "Eat some sugar or the wind will blow you away!"
    | bmi <= normal = "You're supposedly Normal. Pffft, I bet you're ugly!"
    | bmi <= fat = "Ay fatty boom-boom! Ay fatty boom-boom"
    | otherwise   = "You are a whale! Congratulations"
    where bmi = weight / height ^ 2
          skinny = 18.5
          normal = 20.5
          fat    = 30.0
```

Lets examine. We use guards to return the specific message depending on our `bmi` and use `where` to calculate `bmi` outside of the guards (reduces repetition). We also introduced values for `skinny`, `normal` and `fat` in the `where` bindings to make our code more readable. 

#### Pattern matching

One more cool thing we can do is make use of pattern matching to make our code even more concise:

```hs
...
where bmi = weight / height ^ 2
      (skinny, normal, fat) = (18.5, 20.5, 30.0)
```

Another example of pattern matching in `where` bindings is the following function:

```hs
initials :: String -> String -> String
initials firstname lastname = [f] ++ ". " ++ [l] ++ "."
    where (f:_) = firstname
          (l:_) = lastname
``` 

We could have done this pattern matching directly in the function's parameters (it would have been shorter and clearer actually) but this just goes to show that it's possible to do it in where bindings as well.

## Let .. in

Very similar to `where` bindings are `let` bindings. Where bindings span accross guards. Let bindings are very local. 

```hs
cylinder :: (RealFloat a) => a -> a -> a
cylinder r h = 
    let sideArea = 2 * pi * r * h
        topArea  = pi * r^2
    in  sideArea + 2 * topArea 
```

```hs
ghci> cylinder 2 2
50.26548245743669
``` 

The form is `let <bindings> in <expression>`. The names that you define in the *let* part are accessible (locally) to the expression after the *in* part.

We can define *inline let bindings*.

```hs
ghci> 4 * (let a = 9 in a + 1) + 2  
42
```

We can even define multiple variables inline separated by `;`.


```hs
ghci> 4 * (let a = 9; b = 1 in a + b) + 2  
42
```

We can introduce locally scoped functions.

```hs
ghci> [let square x = x * x in (square 5, square 7, square 11)]
[(25,49,121)]
```

We can also use pattern matching.

```hs
ghci> (let (a,b,c) = (1,2,3) in a + b + c) * 100
600
```

And use them in *list comprehensions*.

```hs
ghci> [ bmi | (w, h) <- [(80,1.70), (80,1.50)], let bmi = w / h ^ 2]
[22.1606648199446,27.68166089965398,35.55555555555556]
```

And even use their expressions in *predicates* to only return the BMI of obese people.

```hs
ghci> [ bmi | (w, h) <- [(80,1.70), (80,1.50)], let bmi = w / h ^ 2, bmi >= 30]
[35.55555555555556]
```

The main difference between `let` and `where` is that `let` bindings are expressions. (They have a type)  

Further they are visible locally, within their expression, (exception is the list comprehensions where the visibility of the names is already predefined there). 

`where` bindings have a broader scope and are f.e. visible across guards in functions.

Another difference is that in `where` bindings the names come after the function they are being used in. That way, the function body is closer to its name and type declaration which some find more readable. 


```hs
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
``` 

## Case expressions

```hs
    case expression of pattern -> result  
                       pattern -> result  
                       pattern -> result  
                       ...  
```

Whereas pattern matching on function parameters can only be done when defining functions, case expressions can be used pretty much anywhere. For instance:

```hs
describeList :: [a] -> String  
describeList xs = "The list is " ++ case xs of [] -> "empty."  
                                               [x] -> "a singleton list."
                                               xs -> "a longer list."  
```

```hs
ghci> describeList ""
"The list is empty."
ghci> describeList "a"
"The list is a singleton list."
ghci> describeList "test"
"The list is a longer list."
```
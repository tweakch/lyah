# Higher Order Functions

## Curried functions

`test :: a -> a -> a`

## Some higher orderism is in order

`higherOrder :: (a -> b) -> a -> b` 

## Maps and filters

```hs
ghci> :t map
map :: (a -> b) -> [a] -> [b]
```

```hs
ghci> :t filter
filter :: (a -> Bool) -> [a] -> [a]
```

## Lambdas

Anonymous functions used only once. 

```hs
ghci> map (\x -> x + 3) [2,3,4]
[5,6,7]
```

better to use *partial application* using the `(+3)` function in this case: 

```hs
ghci> map (+3) [2,3,4]
[5,6,7]
```

## Only folds and horses

```hs
ghci> :t foldr
foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b
``` 

```hs
ghci> :t foldl
foldr :: Foldable t => (b -> a -> b) -> b -> t a -> b```

## Function application with $

```hs
($) :: (a -> b) -> a -> b
f $ x = f x
```

## Function composition

```hs
ghci> :t (.)
(.) :: (b -> c) -> (a -> b) -> a -> c
```
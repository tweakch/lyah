doubleMe x = x + x

doubleUs x y = doubleMe x + doubleMe y

doubleSmallNumber x = if x > 100
    then x
    else doubleMe x

doubleSmallNumber' x = (if x > 100 then x else doubleMe x) + 1

primeNumbers = [2,3,5,7,11,13]

boomBang xs = [ if odd x then "BOOM!" else "BANG!" | x <- xs, x > 10]
:{
mymap f [] = []
mymap f (x:xs) = f x : (mymap f xs)  
:}

:{
eeeooo n = sum [x | x <- [1..n] , n `mod` x == 0]
:}
:{
even [] = []
even (x:xs) = foldr (\x y -> (y + ((1 + x) `mod` 2))) 0 (x:xs)
:}
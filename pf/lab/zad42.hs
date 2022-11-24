:{
nondec [x] = True
nondec (x:xs) = x <= (head xs) && nondec xs
:}

:{
nondec [x] = True
nondec (x:xs) = foldr (\(yr,yl) x-> x && yr <= yl ) (x <= head xs) (zip xs (tail xs))
:}
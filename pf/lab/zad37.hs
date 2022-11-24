:{
qs [] = []
qs [x] = [x]
qs (x:xs) = qs [t|t <- xs,t<=x] ++ [x] ++ qs [t|t <- xs, t>x]
:}
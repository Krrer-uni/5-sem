:{
    mymap f [] = []
    mymap f (x:xs) = f x : mymap f xs
:}



#zad28 - TODO
:{
    mysum xs = mymap (\(x,y) -> x + y) zip xs (tail xs)
:}


#zad29
:{
myhelp [] ys = ys
myhelp (x:xs) ys = if (x `elem` ys) then myhelp xs ys else myhelp xs ([x] ++ ys) 
:}

mynub (x:xs) = reverse (myhelp (x:xs) [])

#zad30
:{
myinitshelp [] ys = ys
myinitshelp (x:xs) ys = myinitshelp xs ((head ys ++ [x]):ys)
:}
myinits xs = myinitshelp xs [[]]                  

#zad31
:{
mytails [] ys = ys
mytails (x:xs) ys = mytails xs ((x:xs):ys) 
:}

#zad32
:{
partitionshelp [] ys  = ys
partitionshelp (x:xs) ys = partitionshelp xs [(((head (head(ys)) ++ [x] ) ) ):[xs]]++ys
:}

partitions (x:xs) = partitionshelp (x:xs) [[[],x:xs]] 

#zad 35

:{
permutationshelp [] ys = ys
permutationshelp (x:xs) ys = permutationshelp xs (ys ++ (map (\a -> a ++ [x] ) ys ))
:}

permutation xs = permutationshelp xs [[]]

#zad kolos


:{
foldr 
:}

kolsum n = foldr (\x y -> 1/((x+1)^2) + y) 0 [1..n]
:{
mean [] = 0
mean xs =  (\ (x,y) -> x/(y)) (foldr (\ x (p,q) -> (x+p,q+1)) (0,0) xs)
:}

var xs = (\ (x,y) -> x/(y-1)) (foldr (\ x (p,q) -> (x+p,q+1)) (0,0)  (map (\x -> (x - (mean xs))^2) xs ))
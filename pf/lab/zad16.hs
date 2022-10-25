euler n = length [ k | k <- [1..n], gcd k n == 1 ]
euler n = sum [euler k | k <- [1..n] mod n k == 0]


:{
g a b | b == 0 = 1
      | otherwise = ((g (a-1) (b-1) * a )/ b)
:}


:{
    
:}
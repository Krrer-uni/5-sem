coprime n =(length [ t |t <- [1..n-1], gcd t n == 1]) --funkcja pomocnicza dla czytelności wyliczjąca moc zbioru liczb względnie pierwszych z n ze zbioru [1..n-1
primes n = if n <= 1 then 0 else length [t|t <- [1..n],  coprime t == t-1] -1 

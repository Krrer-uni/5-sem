function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
    v::Float64 = 0.0
    it::Int = 0
    err::Int = 0  
    c = (a-b)/2 + b
    
    while abs(f(c)) >= epsilon && abs(a - b) >= delta
        it = it + 1
        if sign(f(a)) == sign(f(b))
            err = 1 
            return (c,v,it,err)
        end
        if sign(f(a)) == sign(f(c))
            a = c
        else
            b = c
        end
        c = (a-b)/2 + b
    end

    v = f(c)
    return (c, v, it, err)
end


mbisekcji( (x -> x^2 - 20.0) , 10.0, 100.0, 0.0000001, 0.000000001)
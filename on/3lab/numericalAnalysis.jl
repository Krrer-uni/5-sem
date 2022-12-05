#Wojciech Rymer

module Numerical

function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
    v::Float64 = 0.0
    it::Int = 0
    err::Int = 0  
    c = (a/2-b/2) + b
    
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

function mstycznych(f,pf,x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    a_eps = 0
    it = 0
    err = 0
    
    if it >= maxit
        err = 1
        return (x0, f(x0), it, err) 
    end

    a = pf(x0)
    if abs(a) <= a_eps
        err = 2
        return (x0, f(x0), it, err)
    end
    x = x0 - f(x0)/a
    it = it + 1;

    last_x = x0
    while true     
        if it >= maxit
            err = 1
            return (x, f(x), it, err) # exit iteration
        end   
        a = pf(x)
        if abs(a) <= a_eps
            err = 2
            return (x, f(x), it, err) # exit derivative
        end
        last_x = x 
        x = x - f(x)/a
        it = it + 1
        if abs(f(x)) < epsilon || abs(x - last_x) < delta
            return (x, f(x), it, err) # exit delta or epsilon
        end 
        
    end
end

function msiecznych(f, x0::Float64, x1::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    it = 0
    err = 0
    
    if it >= maxit
        err = 1
        return (x0, f(x0), it, err) 
    end

    a = (f(x1) - f(x0))/(x1 - x0)
    x1 = x1 - (f(x1))/a
    it = it + 1;

    while true
        if it >= maxit
            err = 1
            return (x1, f(x1), it, err) # exit iteration
        end   
        a  = (f(x1) - f(x0))/(x1 - x0)
        x0 = x1
        x1 = x1 - f(x1)/a
        it = it + 1
        if abs(f(x1)) < epsilon || abs(x0 - x1) < delta
            return (x1, f(x1), it, err) # exit delta or epsilon
        end 
        
    end
end

end
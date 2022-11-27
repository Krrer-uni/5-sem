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



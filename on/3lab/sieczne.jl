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



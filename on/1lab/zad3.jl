# by Wojciech Rymer

using Printf

function distribution(T)
    lb::T = 1.0
    ub::T = 2.0
    diff = (nextfloat(lb) - lb)::T
    while lb != ub
        a::T =nextfloat(lb) 
        if (a - lb)::T != diff
            println("error")
        end

        lb = a
    end
end

function dist(lower::Float64, upper::Float64)
    lb::Float64 = lower
    ub::Float64 = upper
    d::Float64 = nextfloat(lb) - lb
    println(bitstring(lb))
    println(bitstring(ub))
    println(isequal(2^-52,nextfloat(lb) - lb))
    
end
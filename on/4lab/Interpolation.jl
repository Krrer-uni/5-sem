module Interpolation
export  ilorazyRoznicowe, warNewton, naturalna, rysujNnfx

using Plots
function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})
    ilorazy =  copy(f)
    for i in 2:length(ilorazy)
        for j in collect(StepRange(length(ilorazy),-1,i))
            ilorazy[j] = (ilorazy[j] - ilorazy[j-1])/(x[j] - x[j-i+1])
        end
    end
    return ilorazy
end

function warNewton(x::Vector{Float64}, fx::Vector{Float64}, t::Float64)
    x_len = length(x)
    result = fx[x_len]
    for i in collect(StepRange(x_len-1,-1,1))
        result = fx[i] + result * (t - x[i])
    end
    return result
end

function naturalna(x::Vector{Float64}, fx::Vector{Float64})
    x_len = length(x)
    nat = zeros(Float64,x_len)
    nat[1] = fx[x_len]
    for i in collect(StepRange(x_len,-1,2))
        step_nat = zeros(Float64,x_len + 1)
        for j in collect(StepRange(1,1,x_len - i +1))
            step_nat[j] += nat[j]*(-x[i-1])
            step_nat[j+1] += nat[j] 
        end
        for i in 1:x_len
            nat[i] = step_nat[i]
        end
        nat[1] += fx[i-1]
    end 
    return nat
end

function rysujNnfx(f,a::Float64,b::Float64,n::Int)
    x = collect(range(a,b,n))
    y = map(f, x)
    fx = ilorazyRoznicowe(x,y)

    base = collect(range(a,b,1000))
    
    interpol = plot(base, [(t -> warNewton(x,fx,t)),f], label=["interpolated" "f"])
    png(interpol,string(f) * string(a) * string(b) * string(n))
end

end
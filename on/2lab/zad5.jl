# Wojciech Rymer
using Printf
using Plots
function normal_iter(r,p_0)
    sol = zeros(40)
    p(x) = x +  r*x*(1-x)
    sol[1] = p(p_0)
    for i in 2:40
        sol[i] = p(sol[i-1])
    end
    return sol
end

function cut_iter(r,p_0)
    sol = zeros(40)
    p(x) = x +  r*x*(1-x)
    sol[1] = p(p_0)
    for i in 2:40
        sol[i] = p(sol[i-1])
        if i == 10
            sol[i] = 0.722
        end
    end
    return sol
end


function iterative(r,p_0,T)
    sol = zeros(T,40)
    p(x) = (x +  r*x*(1.0-x))
    sol[1] = p(p_0)
    for i in 2:40
        sol[i] = p(sol[i-1])
    end
    return sol
end

a = normal_iter(3.0,0.01)
b = cut_iter(3.0,0.01)
c32 = iterative(Float32(3.0),Float32(0.01),Float32)
c64 = iterative(3.0::Float64,0.01::Float64,Float64)
# println(a)
# println(b)
# println(c32)
# println(c64)
resultsa = [a,b,map(abs,a-b)]
resultsb = [c32,c64,map(abs,c32-c64)]
# display(resultsa)
# display(resultsb)
plot([1:40],resultsa[1,:],label="standard")
plot!([1:40],resultsa[2,:],label="rounded")
png("rounding.png")
# plot!([1:40],resultsa[3,:],label="dif")
plot([1:40],resultsb[2,:],label="Float64")
plot!([1:40],resultsb[1,:],label="Float32")

png("precision.png")
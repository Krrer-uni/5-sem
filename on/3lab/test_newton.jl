include("newton.jl")

mstycznych((x -> sin(x) - (x/2)^2), x -> cos(x) - x/2, 1.5, 1/2*10^(-5),1/2*10^(-5),100000)
# mstycznych((x->x^2 - 20.), x->2*x, 5.,0.00000000001,0.5,1000000000)
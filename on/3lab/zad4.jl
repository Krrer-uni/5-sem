include("bisekcja.jl")

println(mbisekcji(x->exp(x) -3*x, -10.,1.5,10^(-4),10^(-4)))
println(mbisekcji(x->exp(x) -3*x, 1.5,10.,10^(-4),10^(-4)))

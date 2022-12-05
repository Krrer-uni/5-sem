#Wojciech Rymer
include("numericalAnalysis.jl")

println(Numerical.mbisekcji(x->exp(x) -3*x, -10.,1.,10^(-4),10^(-4)))
println(Numerical.mbisekcji(x->exp(x) -3*x, 1.,10.,10^(-4),10^(-4)))

#Wojciech Rymer
include("numericalAnalysis.jl")

#test iterations
println(Numerical.mstycznych((x -> (x/2)^2 + 1), x-> x/2, 1.5, 1/2*10^(-5),1/2*10^(-5),1000))
#test derivative
println(Numerical.mstycznych((x -> cos(x)), x-> -sin(x), 0.0, 1/2*10^(-5),1/2*10^(-5),1000))
#test function 
println(Numerical.mstycznych((x -> cos(x)), x-> -sin(x), 1.0, 1/2*10^(-5),1/2*10^(-5),1000))
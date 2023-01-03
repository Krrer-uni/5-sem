#Wojciech Rymer
include("numericalAnalysis.jl")

#test iterations
println(Numerical.msiecznych((x -> (x)^2 + 4), 0.0, 0.5, 1/2*10^(-5),1/2*10^(-5),1000))
#test function 
println(Numerical.msiecznych((x -> cos(x)), 0.0, 1.0, 1/2*10^(-5),1/2*10^(-5),1000))
#test error
println(Numerical.msiecznych((x -> (x)^2 + 4),-0.5, 0.5, 1/2*10^(-5),1/2*10^(-5),1000))

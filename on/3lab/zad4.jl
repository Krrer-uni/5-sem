#Wojciech Rymer
include("numericalAnalysis.jl")

println(Numerical.mbisekcji(x -> sin(x) - (x/2)^2,1.5,2.0,(1/2)*10^(-5),(1/2)*10^(-5)))
println(Numerical.mstycznych((x -> sin(x) - (x/2)^2), x -> cos(x) - x/2, 1.5, 1/2*10^(-5),1/2*10^(-5),100000))
println(Numerical.msiecznych(x -> sin(x) - (x/2)^2, 1.0, 2.0, 1/2*10^(-5),1/2*10^(-5),100000))
#Wojciech Rymer
include("numericalAnalysis.jl")

#test error code
println(Numerical.mbisekcji(x -> x^2,-2.230,2.320,(1/2)*10^(-5),(1/2)*10^(-5)))
#test wyliczania x^3
println(Numerical.mbisekcji(x -> x^3 - 123,-196.675,834.396,(1/2)*10^(-5),(1/2)*10^(-5)))
#test wyliczania sin(x)
println(Numerical.mbisekcji(x -> sin(x),-pi/2.12,5.002/2pi,(1/2)*10^(-5),(1/2)*10^(-5)))

println(Numerical.mbisekcji(x -> sin(x),-pi/2.12,5.002/2pi,(1/2)*10^(-5),(1/2)*10^(-5)))
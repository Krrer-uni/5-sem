include("bisekcja.jl")

mbisekcji(x -> sin(x) - (x/2)^2,1.5,2.0,(1/2)*10^(-5),(1/2)*10^(-5))
include("sieczne.jl")

msiecznych(x -> sin(x) - (x/2)^2, 1.0, 2.0, 1/2*10^(-5),1/2*10^(-5),100000)
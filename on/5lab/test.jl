include("matrixSolver.jl")
include("reader.jl")
using Statistics

# A = loadMatrix("Dane16_1_1/A.txt")
# b = loadVector("Dane16_1_1/b.txt")
# x = ones(Float64,A[2])

# println(solveGaussForb(A,x))
# solveGaussForx(A,b)
A = loadMatrix("test/Dane10000_1_1/A.txt")
b = loadVector("test/Dane10000_1_1/b.txt")
x = ones(Float64,A[2]) * 2
@time b = solveGaussForb(A,x)
println(mean(map(abs,solveGaussForx(A,b) - x)))
println(solveGaussForxParttialChoice(A,b) - x)

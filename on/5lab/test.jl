include("matrixSolver.jl")
include("reader.jl")
using Statistics

# A = loadMatrix("Dane16_1_1/A.txt")
# b = loadVector("Dane16_1_1/b.txt")
# x = ones(Float64,A[2])

# println(solveGaussForb(A,x))
# solveGaussForx(A,b)
A = loadMatrix("test/Dane500000_1_1/A.txt")
b = loadVector("test/Dane500000_1_1/b.txt")
x = ones(Float64,A[2]) * 2
b = solveGaussForb(A,x)
decompA = LU(A)
@time println(mean(map(abs,solveLU(decompA,b) - x)))
# @time println(mean(map(abs,solveGaussForx(A,b) - x)))
# @time println(mean(map(abs,solveGaussForxPartialChoice(A,b) - x)))

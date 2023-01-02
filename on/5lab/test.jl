include("matrixSolver.jl")
include("reader.jl")

# A = loadMatrix("Dane16_1_1/A.txt")
# b = loadVector("Dane16_1_1/b.txt")
# x = ones(Float64,A[2])

# println(solveGaussForb(A,x))
# solveGaussForx(A,b)
A = loadMatrix("Dane16_1_1/A.txt")
b = loadVector("Dane16_1_1/b.txt")
x = ones(Float64,A[2])
@time solveGaussForb(A,x)
@time solveGaussForx(A,b)
include("matrixSolver.jl")

A = loadMatrix("Dane16_1_1/A.txt")
b = loadVector("Dane16_1_1/b.txt")
x = ones(Float64,A[2])

println(solveGaussForb(A,x))

A = loadMatrix("Dane50000_1_1/A.txt")
b = loadVector("Dane50000_1_1/b.txt")
x = ones(Float64,A[2])
@time solveGaussForb(A,x);
@time A[1]*x
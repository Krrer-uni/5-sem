#Wojciech Rymer
include("numericalAnalysis.jl")
f1 = x -> exp(1-x) - 1
f2 = x -> x * exp(-x)
pf1 = x -> - exp(1-x)
pf2 = x -> (1-x) * exp(-x)

epsilon = 10^(-5)
delta = 10^(-5)
maxit = 10000

println("iterowanie po przedziale")
#f1 bisekcja
ans_vec = []
for i in -1000:3:1000 
    a = -1.0 + i
    b = 1.0 + i
    push!(ans_vec, tuple(Numerical.mbisekcji(f1 ,a , b, epsilon,delta)...,(a,b)))
end
filter!(x -> x[4] == 0 ,ans_vec)
println(ans_vec[findmin(x->abs(x[2]),ans_vec)[2]])

#f1 newton
ans_vec = []
for i in -1000:3:1000 
    push!(ans_vec, tuple(Numerical.mstycznych(f1, pf1, Float64(i), epsilon,delta, maxit)...,(i)))
end
filter!(x -> x[4] == 0 ,ans_vec)
println(ans_vec[findmin(x->abs(x[2]),ans_vec)[2]])

#f1 sieczne
ans_vec = []
for i in -1000:3:1000 
    a = -1.0 + i
    b = 1.0 + i
    push!(ans_vec, tuple(Numerical.msiecznych(f1 ,a , b, epsilon,delta,maxit)...,(a,b)))
end
filter!(x -> x[4] == 0 ,ans_vec)
println(ans_vec[findmin(x->abs(x[2]),ans_vec)[2]])

#f2 bisekcja
ans_vec = []
for i in -1000:3:1000 
    a = -1.0 + i
    b = 1.0 + i
    push!(ans_vec, tuple(Numerical.mbisekcji(f2 ,a , b, epsilon,delta)...,(a,b)))
end
filter!(x -> x[4] == 0 ,ans_vec)
println(ans_vec[findmin(x->abs(x[2]),ans_vec)[2]])

#f2 newton
ans_vec = []
for i in -1000:3:1000 
    push!(ans_vec, tuple(Numerical.mstycznych(f2, pf2, Float64(i), epsilon,delta, maxit)...,(i)))
end
filter!(x -> x[4] == 0 ,ans_vec)
println(ans_vec[findmin(x->abs(x[2]),ans_vec)[2]])

#f2 sieczne
ans_vec = []
for i in -1000:3:1000 
    a = -1.0 + i
    b = 1.0 + i
    push!(ans_vec, tuple(Numerical.msiecznych(f2 ,a , b, epsilon,delta,maxit)...,(a,b)))
end
filter!(x -> x[4] == 0 ,ans_vec)
filter!(x -> x[5][2] != 0.0, ans_vec)
println(ans_vec[findmin(x->abs(x[2]),ans_vec)[2]])

println("f2 bisekcja")
println(Numerical.mbisekcji(f2 ,-1. , 1., epsilon,delta))
println(Numerical.mbisekcji(f2 ,-1. , 1.1, epsilon,delta))

println("f2 styczne")
println(Numerical.mstycznych(f2, pf2, -1., epsilon,delta, maxit))

println("f2 sieczne")
println(Numerical.msiecznych(f2 ,-1. , -2., epsilon,delta,maxit))

println("analiza Newton")
println(Numerical.mstycznych(f1, pf1, 2., epsilon,delta, maxit))
println(Numerical.mstycznych(f1, pf1, 5., epsilon,delta, maxit))
println(Numerical.mstycznych(f1, pf1, 7, epsilon,delta, maxit))
println(Numerical.mstycznych(f1, pf1, 9., epsilon,delta, maxit))
println(Numerical.mstycznych(f1, pf1, 500., epsilon,delta, maxit))
println(Numerical.mstycznych(f2, pf2, 10.0, epsilon,delta, maxit))
println(Numerical.mstycznych(f2, pf2, 100.0, epsilon,delta, maxit))
println(Numerical.mstycznych(f2, pf2, 500.0, epsilon,delta, maxit))
println(Numerical.mstycznych(f2, pf2, 1.0, epsilon,delta, maxit))
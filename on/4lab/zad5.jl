include("Interpolation.jl")
using .Interpolation

f =  x -> exp(x)
a = 0.0
b = 1.0
for n in [5,10,15]
    print(n)
    rysujNnfx(f,a,b,n)
end


f =  x -> x^2*sin(x)
a = -1.0
b = 1.0
for n in [5,10,15]
    rysujNnfx(f,a,b,n)
end

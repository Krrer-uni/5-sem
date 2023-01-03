include("Interpolation.jl")
using .Interpolation

f =  x -> abs(x)
a = -1.0
b = 1.0
for n in [5,10,15]
    print(n)
    rysujNnfx(f,a,b,n)
end


f =  x -> 1/(1+x^2)
a = -5.0
b = 5.0
for n in [5,10,15]
    rysujNnfx(f,a,b,n)
end

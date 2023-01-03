include("Interpolation.jl")
using .Interpolation

# test zad1
x = [3.,1.,5.,6.]
y = [1.,-3.,2.,4.]
fx = ilorazyRoznicowe(x,y)
println(fx)
# test zad2
f = (x -> sin(x^2))
x = collect(range(-1,1,10))
y = map(f, x)
fx = ilorazyRoznicowe(x,y)
println(warNewton(x,fx,0.981))
rysujNnfx(f,-1.,1.,10)

# test zad3
println(naturalna(x,fx))
f = (x -> x^2)
x = collect(range(-1,1,10))
y = map(f, x)
fx = ilorazyRoznicowe(x,y)
println(naturalna(x,fx))
# zgadza się bo a_n = 0.0


# test zad 4
rysujNnfx((x->x+sin(6*x^2)^2),-1.0,1.0,5)
rysujNnfx((x->x+sin(6*x^2)^2),-1.0,1.0,10)
rysujNnfx((x->x+sin(6*x^2)^2),-1.0,1.0,15)
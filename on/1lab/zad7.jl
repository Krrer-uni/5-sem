# by Wojciech Rymer

using Printf
using Plots
function calculate_der(f,x,h)
    return (f(x+h) - f(x))/h
end

f(x) = sin(x) + cos(3x)
exact = 0.1169422816885380510987021990186457641915106278611254752144493316
val = zeros(0)
err = zeros(0)
for i in 0:54
    x = calculate_der(f,1.0,2.0^Float64(-i))
    er = abs(exact - x)
    append!(val,x)
    append!(err,er)
    @printf("%d,%.10e,%.10e,%.10e\n",i,2.0^(-i),x,er)
end

plot([0:54],val, label = "f(2^-x)")
plot!([0:54],[exact for e in 0:54], label = "true val")

# plot([20:40],val[20:40], label = "f(2^-x)")
# plot!([20:40],[exact for e in 20:40], label = "true val")

xlabel!("x")
# png("zad7png")
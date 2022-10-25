# by Wojciech Rymer

using Printf

function f(x)
    return sqrt(x^2 + 1) - 1
end

function g(x)
    return x^2/(sqrt(x^2+1)+1)
end


for i in 1:20
    x = 8.0^(-i)
    fx = f(x)
    gx = g(x)
    @printf("x = %.10e f(x) = %.10e g(x) = %.10e\n",x,fx,gx)
end
# Wojciech Rymer

using Polynomials
using Printf
# zmien -210 na -210-2^(-23)
ax=[1, -210-2^(-23), 20615.0,-1256850.0,
53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,          
11310276995381.0, -135585182899530.0,
1307535010540395.0,     -10142299865511450.0,
63030812099294896.0,     -311333643161390640.0,
1206647803780373360.0,     -3599979517947607200.0,
8037811822645051776.0,      -12870931245150988800.0,
13803759753640704000.0,      -8752948036761600000.0,
2432902008176640000.0]


P = Polynomial(reverse(ax))

function p_(x)
    a = 1.0
    for i in 1:20 
        a = a * (x-i)
    end
    return a
end

R = roots(P)
function check()
    i = 1.0
    for r in R
        a = abs(P(r))
        b = abs(p_(r))
        k = abs(r-i)
        i=i+1
        @printf("%.10e,%.10e,%.10e\n",a,b,k)
    end
end

check()
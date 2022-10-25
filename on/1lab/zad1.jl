# by Wojciech Rymer

using Printf

function checkeps(T)
    f16::T = 1.0;
    i::T = 1.0;
    one::T = 1.0;
    while (f16 + i)::T > one
        i= i/2
    end
    ep = eps(T)
    @printf("eps() = %.e \ncalculated = %.e\n",ep,i*2)
    @printf("ifequal = %s\n",isequal(ep,i*2))
end 

function checketa(T)
    i::T = 1.0
    while i/T(2.0) > T(0.0)
        i = i/T(2.0)
    end
    ep = nextfloat(T(0.0))
    @printf("eta with nextfloat = %.e \ncalculated eta = %.e\n", nextfloat(T(0.0)), i)
    @printf("ifequal = %s\n",isequal(ep,i))
end

function checkmax(T)
    i::T = 1.0
    multiplicant::T = 2.0
    while !isinf((nextfloat(i)))
        if !isinf(T(i*multiplicant))
            i *= T(multiplicant)
        else
            multiplicant = prevfloat(multiplicant)
        end
    end
    ep = floatmax(T)
    @printf("max with floatmax = %.e \ncalculated eta = %.e\n", floatmax(T), i)
    @printf("ifequal = %s\n",isequal(ep,i))
end
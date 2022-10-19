using Printf

function calceps(T)
    three::T = 3.0
    four::T = 4.0
    i::T = three * T(T(four / three) - T(1.0)) - T(1.0)
    ep = eps(T)
    @printf("eps = %.e\ncalculated = %.e\n", ep, i)
    @printf("ifequal = %s\n",isequal(ep,i))

end
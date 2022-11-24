import Printf

function computePrefix(P)
    m = length(P)
    dic = zeros(Int32,m)
    dic[1] = 0
    k = 0
    for q in 2:m
        while k > 0 && P[k+1] != P[q]
            k  = dic[k]
        end
        if P[k+1] == P[q]
            k = k + 1
        end
        dic[q] = k
    end
    return dic
end

function KMP(T,P)
    n = length(T)
    m = length(P)
    dic = computePrefix(P)
    # println(dic)
    match = []
    q = 0
    for i in 1:n
        while q > 0 && P[q+1] != T[i]
            q = dic[q]
        end
        if P[q+1] == T[i]
            q = q+1
        end
        if q==m
            append!(match,i-m)
            q = dic[q]
        end
    end
    return match
end

pattern = ""
filename = ""
if size(ARGS)[1] >= 2 
    pattern = ARGS[1]
    filename = ARGS[2]
end
# println(pattern)
file = String(read("cases-EMOJI.txt"))
iterator =map( x->getfield(x ,2), collect(enumerate(file)))
pattern = map( x->getfield(x ,2), collect(enumerate(pattern)))
@show(KMP(iterator,pattern))

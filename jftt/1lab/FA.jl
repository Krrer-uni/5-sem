function is_suffix(A,B)
    k = length(A)
    l = length(B)
    return A == B[l-k+1:l]
end
function compute_transition(P,E)
    m = length(P)
    n = length(E)
    delta = []
    for q in 0:m
        D = Dict()
        for a in E
            k = min(m+1,q+2)
            while true
                k = k -1
                if is_suffix(P[1:k],[P[1:q] ;a])
                    break
                end
            end
            get!(D,a,k)
        end
        push!(delta,D)
    end
    return delta
end

function FA(T,P)
    n =length(T)
    m = length(P)
    q = 0
    E = unique(P)
    match = []
    delta = compute_transition(P,E)
    for i in 1:n
        q = get(delta[q+1],T[i], 0)
        if q == m 
            append!(match, i-m)
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
println(FA(iterator,pattern))

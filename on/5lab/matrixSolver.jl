using SparseArrays

function solveGaussForb(dataA,x)
    A = dataA[1]
    n = dataA[2]
    l = dataA[3]
    b = zeros(Float64,n)
    for i in 1:n
        rowStart = max(1, i - l)
        rowEnd = min(i+l, n)
        for k in rowStart:rowEnd
            b[i] += A[i,k] * x[k]
        end
    end
    return b
end

function solveGaussForx(dataA, b)
    A = dataA[1]
    n = dataA[2]
    l = dataA[3]
    b = b[1]

end
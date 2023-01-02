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

function solveGaussForx(inputA, inputb)
    A = copy(inputA[1])
    n = copy(inputA[2])
    l = copy(inputA[3])
    b = copy(inputb)
    x = zeros(n)
    @time for i in 1:n-1 #column
        firstRow = min(i+1,n)
        lastRow = min(i+l, n)
        
        for k in firstRow:lastRow #row
            q = A[k,i]/A[i,i]
            A[k,i:lastRow] = A[k,i:lastRow] - A[i,i:lastRow] * q
            A[k,i] = 0
            b[k] = b[k] - b[i] * q
        end
    end

    @time dropzeros!(A)
    x[n] = b[n] / A[n,n]

    @time for i in (n-1):-1:1
        rowEnd = min(i+l,n)
        
        for k in rowEnd:-1:i+1
            b[i] = b[i] - A[i,k] * x[k]
        end
        x[i] = b[i] / A[i,i]
    end
    
    return x
end
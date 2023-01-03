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
    A = transpose(copy(inputA[1]))
    n = copy(inputA[2])
    l = copy(inputA[3])
    b = copy(inputb)
    x = zeros(n)
    @time for i in 1:n-1 #column
        firstRow = min(i+1,n)
        lastRow = min(i+l, n)
        
        for k in firstRow:lastRow #row
            if A[i,k] == 0
                continue
            end
            q = -A[i,k]/A[i,i]
           A[i:lastRow,k] = A[i:lastRow,k] + A[i:lastRow,i] * q
            A[i,k] = 0
            b[k] = b[k] + b[i] * q
        end
    end
    
    A = transpose(A)
    dropzeros!(A)
    x[n] = b[n] / A[n,n]

    for i in (n-1):-1:1
        rowEnd = min(i+l,n)
        
        for k in rowEnd:-1:i+1
            b[i] = b[i] - A[i,k] * x[k]
        end
        x[i] = b[i] / A[i,i]
    end
    
    return x
end

function solveGaussForxParttialChoice(inputA, inputb)
    A = transpose(copy(inputA[1]))
    n = copy(inputA[2])
    l = copy(inputA[3])
    b = copy(inputb)
    x = zeros(n)

    rowlookup = collect(1:n)

    for i in 1:n-1 #column
        firstRow = min(i+1,n)
        lastRow = min(i+l, n)
        t = i
        max = A[i,i]
        for k in firstRow:lastRow #row
            coef = A[i,k] 
            if coef > max
                max = coef
                t = k
            end
    
        end
        A[:,t],A[:,i] = A[:,i],A[:,t]
        b[t],b[i] = b[i],b[t]
        # println(b)
        rowEnd = min(i+2*l,n)
        for k in firstRow:lastRow #row
            if A[i,k] == 0
                continue
            end
            q = -A[i,k]/A[i,i]
            A[i:rowEnd,k] = A[i:rowEnd,k] + A[i:rowEnd,i] * q
            A[i,k] = 0
            b[k] = b[k] + b[i] * q
        end
    end
    
    A = transpose(A)
    dropzeros!(A)
    x[n] = b[n] / A[n,n]

    for i in (n-1):-1:1
        rowEnd = min(i+l,n)
        
        for k in rowEnd:-1:i+1
            b[i] = b[i] - A[i,k] * x[k]
        end
        x[i] = b[i] / A[i,i]
    end
    
    return x
end
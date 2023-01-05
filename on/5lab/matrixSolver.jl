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
    for i in 1:n-1 #column
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

function solveGaussForxPartialChoice(inputA, inputb)
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
        max = A[i,rowlookup[i]]
        for k in firstRow:lastRow #row
            coef = A[i,rowlookup[k]] 
            if coef > max
                max = coef
                t = k
            end
        end
        b[t],b[i] = b[i],b[t]
        rowlookup[t],rowlookup[i] = rowlookup[i],rowlookup[t]

        rowEnd = min(i+2*l,n)
        for k in firstRow:lastRow #row
            if A[i,rowlookup[k]] == 0
                continue
            end
            q = -A[i,rowlookup[k]]/A[i,rowlookup[i]]
            A[i:rowEnd,rowlookup[k]] = A[i:rowEnd,rowlookup[k]] + A[i:rowEnd,rowlookup[i]] * q
            A[i,rowlookup[k]] = 0
            b[k] = b[k] + b[i] * q
        end
    end
    
    A = transpose(A)
    dropzeros!(A)
    x[n] = b[n] / A[rowlookup[n],n]

    for i in (n-1):-1:1
        rowEnd = min(i+l*2,n)
        
        for k in rowEnd:-1:i+1
            b[i] = b[i] - A[rowlookup[i],k] * x[k]
        end
        x[i] = b[i] / A[rowlookup[i],i]
    end
    
    return x
end

function LU(inputA)
    A = transpose(copy(inputA[1]))
    n = copy(inputA[2])
    l = copy(inputA[3])
    for i in 1:n-1 #column
        firstRow = i+1
        lastRow = min(i+l, n)
        
        for k in firstRow:lastRow #row
            if A[i,k] == 0
                continue
            end
            q = -A[i,k]/A[i,i]
            A[i:lastRow,k] = A[i:lastRow,k] + A[i:lastRow,i] * q
            A[i,k] = -q
        end
    end
    
    A = transpose(A)
    dropzeros!(A)
    return (A,n,l)
end

function solveLU(inputLU,b)
    LU = inputLU[1]
    n = inputLU[2]
    l = inputLU[3]
    y = zeros(Float64,n)
    x = zeros(Float64,n)

    y[1] = b[1]

    for i in 2:n
        rowStart = max(i-l,1)
        
        for k in rowStart:i-1
            b[i] = b[i] - LU[i,k] * y[k]
        end
        y[i] = b[i]
    end
    
    x[n] = y[n] / LU[n,n]

    for i in (n-1):-1:1
        rowEnd = min(i+l*2,n)
        
        for k in rowEnd:-1:i+1
            y[i] = y[i] - LU[i,k] * x[k]
        end
        x[i] = y[i] / LU[i,i]
    end

    return x
end

function pcLU(inputA)
    A = transpose(copy(inputA[1]))
    n = copy(inputA[2])
    l = copy(inputA[3])
    x = zeros(n)

    rowlookup = collect(1:n)

    for i in 1:n-1 #column
        firstRow = min(i+1,n)
        lastRow = min(i+l, n)
        t = i
        max = A[i,rowlookup[i]]
        for k in firstRow:lastRow #row
            coef = A[i,rowlookup[k]] 
            if coef > max
                max = coef
                t = k
            end
        end
        rowlookup[t],rowlookup[i] = rowlookup[i],rowlookup[t]

        rowEnd = min(i+2*l,n)
        for k in firstRow:lastRow #row
            if A[i,rowlookup[k]] == 0
                continue
            end
            q = -A[i,rowlookup[k]]/A[i,rowlookup[i]]
            A[i:rowEnd,rowlookup[k]] = A[i:rowEnd,rowlookup[k]] + A[i:rowEnd,rowlookup[i]] * q
            A[i,rowlookup[k]] = -q
        end
    end
    
    A = transpose(A)
    dropzeros!(A)
    return (A,rowlookup,n,l)
end

function solvePcLU(inputLU,b)
    LU = inputLU[1]
    P = inputLU[2]
    n = inputLU[3]
    l = inputLU[4]
    y = zeros(Float64,n)
    x = zeros(Float64,n)

    y[1] = b[1]

    for i in 2:n
        rowStart = max(i-l,1)
        
        for k in rowStart:i-1
            b[i] = b[i] - LU[P[i],k] * y[k]
        end
        y[i] = b[i]
    end
    
    x[n] = y[n] / LU[P[n],n]

    for i in (n-1):-1:1
        rowEnd = min(i+l*2,n)
        
        for k in rowEnd:-1:i+1
            y[i] = y[i] - LU[P[i],k] * x[k]
        end
        x[i] = y[i] / LU[P[i],i]
    end

    return x
end
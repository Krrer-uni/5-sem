module blocksys
export multiply, gauss, pivotGauss, LU, solveLU, pivotLU, solvePivotLU
    
using SparseArrays

# Function multiplies vector with matrix
# Inputs:
#   dataA: tuple (A,n,l) where A is a matrix, n is a matrix size, l is block size
#   x: vector of size n
function multiply(dataA,x)
    A = dataA[1]
    n = dataA[2]
    l = dataA[3]
    b = zeros(Float64,n) # output vector
    for i in 1:n
        rowStart = max(1, i - l)
        rowEnd = min(i+l, n)
        for k in rowStart:rowEnd
            b[i] += A[i,k] * x[k]
        end
    end
    return b
end

# Function solves Ax=b equation given A and b using Gaussian Elimination
# inputs:
# dataA: tuple (A,n,l) where A is a matrix, n is a matrix size, l is block size
# b: vector of size n
function gauss(inputA, inputb)
    A = transpose(copy(inputA[1])) # transpose to gain fast acces to rows that become transponed to columns
    n = copy(inputA[2])
    l = copy(inputA[3])
    b = copy(inputb)
    x = zeros(n)    # output

    # transform to upper triangular matrix
    for i in 1:n-1 # for each row
        firstRow = min(i+1,n) # first element under diagonal
        lastRow = min(i+l, n) # last element under diagonal
        
        for k in firstRow:lastRow # for each in row
            if A[i,k] == 0
                continue
            end
            q = -A[i,k]/A[i,i] # q coefficient 
           A[i:lastRow,k] = A[i:lastRow,k] + A[i:lastRow,i] * q
            A[i,k] = 0 # element is asigned to zero to avoid precision errors
            b[k] = b[k] + b[i] * q
        end
    end
    
    A = transpose(A) # back to normal
    dropzeros!(A) # get rid of zeroes

    # solve for x 
    x[n] = b[n] / A[n,n] # first element
    for i in (n-1):-1:1 # for each element in x/row in A
        rowEnd = min(i+l,n) # left-most element in row
        for k in rowEnd:-1:i+1
            b[i] = b[i] - A[i,k] * x[k]
        end
        x[i] = b[i] / A[i,i]
    end
    return x
end

# Function solves Ax=b equation given A and b using Gaussian Elimination with partial pivoting
# inputs:
# dataA: tuple (A,n,l) where A is a matrix, n is a matrix size, l is block size
# b: vector of size n
function pivotGauss(inputA, inputb)
    A = transpose(copy(inputA[1]))
    n = copy(inputA[2])
    l = copy(inputA[3])
    b = copy(inputb)
    x = zeros(n) # output
    P = collect(1:n) # Permutation vector

    # transform to upper triangular matrix
    for i in 1:n-1 # for each row
        firstRow = min(i+1,n) # first element under diagonal
        lastRow = min(i+l, n) # first element under diagonal
        t = i # index of max elem
        max = abs(A[i,P[i]]) # max elem
        for k in firstRow:lastRow # find max
            coef = abs(A[i,P[k]]) 
            if coef > max
                max = coef
                t = k
            end
        end
        b[t],b[i] = b[i],b[t]
        P[t],P[i] = P[i],P[t] 

        rowEnd = min(i+2*l,n) # last elem in row
        for k in firstRow:lastRow # for each column
            if A[i,P[k]] == 0
                continue
            end
            q = -A[i,P[k]]/A[i,P[i]]
            A[i:rowEnd,P[k]] = A[i:rowEnd,P[k]] + A[i:rowEnd,P[i]] * q
            A[i,P[k]] = 0
            b[k] = b[k] + b[i] * q
        end
    end
    
    A = transpose(A)
    dropzeros!(A)
    x[n] = b[n] / A[P[n],n]

    for i in (n-1):-1:1 # for each element in x/row in A
        rowEnd = min(i+l*2,n)
        
        for k in rowEnd:-1:i+1 # calculate x_i
            b[i] = b[i] - A[P[i],k] * x[k]
        end
        x[i] = b[i] / A[P[i],i]
    end
    
    return x
end

# Function calculates LU decomposition of matrix
# Inputs:
#   dataA: tuple (A,n,l) where A is a matrix, n is a matrix size, l is block size
function LU(inputA)
    A = transpose(copy(inputA[1]))
    n = copy(inputA[2])
    l = copy(inputA[3])
    for i in 1:n-1 # for each row
        firstRow = i+1 #first element in a row
        lastRow = min(i+l, n) # last element in a row
        
        for k in firstRow:lastRow # for each elem in a row
            if A[i,k] == 0
                continue
            end
            q = -A[i,k]/A[i,i] # coeff
            A[i:lastRow,k] = A[i:lastRow,k] + A[i:lastRow,i] * q
            A[i,k] = -q # remember elemnt of L in A
        end
    end
    
    A = transpose(A)
    dropzeros!(A)
    return (A,n,l)
end

# Function solves LUx=b equation where L and U are from LU decomposition
# Inputs:
#   dataLU: tuple (LU,n,l) where LU is a LU decomposition matrix, n is a matrix size, l is block size
function solveLU(dataLU,b)
    LU = copy(dataLU[1])
    n = copy(dataLU[2])
    l = copy(dataLU[3])
    b = copy(b)
    y = zeros(Float64,n) # y from Ly = b
    x = zeros(Float64,n) # x from Ux = y
    

    #solve Ly = b
    y[1] = b[1]
    for i in 2:n 
        rowStart = max(i-l,1)
        
        for k in rowStart:i-1
            b[i] = b[i] - LU[i,k] * y[k]
        end
        y[i] = b[i]
    end
    
    #solve Ux = y
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

# Function calculates LU decomposition of matrix with partial pivoting 
# Inputs:
#   dataA: tuple (A,n,l) where A is a matrix, n is a matrix size, l is block size
function pivotLU(inputA)
    A = transpose(copy(inputA[1]))
    n = copy(inputA[2])
    l = copy(inputA[3])

    P = collect(1:n) # permutation vector

    for i in 1:n-1 # for each row
        firstRow = min(i+1,n)
        lastRow = min(i+l, n)
        
        t = i # index of max elem
        max = abs(A[i,P[i]]) # max elem
        for k in firstRow:lastRow  # find max
            coef = abs(A[i,P[k]]) 
            if coef > max
                max = coef
                t = k
            end
        end
        P[t],P[i] = P[i],P[t]

        rowEnd = min(i+2*l,n) # last elem in row
        for k in firstRow:lastRow # for each column
            if A[i,P[k]] == 0
                continue
            end
            q = -A[i,P[k]]/A[i,P[i]]
            A[i:rowEnd,P[k]] = A[i:rowEnd,P[k]] + A[i:rowEnd,P[i]] * q
            A[i,P[k]] = -q # store L element in A
        end
    end
    
    A = transpose(A)
    dropzeros!(A)
    return (A,n,l,P)
end

# Function solves LUx=b equation where L and U are from LU decomposition
# Inputs:
#   dataLU: tuple (LU,n,l) where LU is a LU decomposition matrix, n is a matrix size, l is block size
function solvePivotLU(inputLU,inputb)
   LU = copy(inputLU[1])
    n = copy(inputLU[2])
    l = copy(inputLU[3])
    P = copy(inputLU[4])
    b = copy(inputb)
    y = zeros(Float64,n) # y from Ly = b
    x = zeros(Float64,n) # x from Ux = y


    #solve Ly = b
    y[1] = b[P[1]]
    for i in 2:n
        rowStart = max(i-l*2,1)
        
        for k in rowStart:i-1
            b[P[i]] = b[P[i]] - LU[P[i],k] * y[k]
        end
        y[i] = b[P[i]]
    end
    
    #solve Ux = y
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

end
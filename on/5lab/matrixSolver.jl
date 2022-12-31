using SparseArrays

function loadMatrix(name)
    matrix = 0
    n = 0
    m = 0
    open(name, "r") do file
        header = split(readline(file), " ")
        n = parse(Int, header[1])
        m = parse(Int,header[2])
        elem_count = Int((n/m) * m^2 + n - m + ((n/m) - 1) * (2 * m -1) )
        I = zeros(Int,elem_count)
        J = zeros(Int,elem_count)
        V = zeros(Float64,elem_count)
        i = 1
        for line in eachline(file)
            item = split(line, " ")
            I[i] = parse(Int, item[1])
            J[i] = parse(Int, item[2])
            V[i] = parse(Float64, item[3])
            i += 1
        end

        matrix = sparse(I,J,V)
    end
    return (matrix, n, m)
end

function loadVector(name)
    vector = 0
    n = 0
    open(name,"r") do file
        header = split(readline(file), " ")
        n = parse(Int, header[1])
        vector = zeros(Float64, n)
        linecounter = 1
        for line in eachline(file)
            vector[linecounter] = parse(Float64, line)
            linecounter += 1
        end
    end
    return (vector,n)
end

function solveGaussForb(dataA,x)
    A = dataA[1]
    n = dataA[2]
    l = dataA[3]
    b = zeros(Float64,n)
    row_indicies,row_val = 0,0
    for i in 1:l
        for j in 1:5
            b[i] += A[j,i] * x[j] 
    for i in 1:n
        row_indicies,row_val = findnz(A[i,:])
        for k in 1:length(row_indicies)
            b[i] += x[row_indicies[k]] * row_val[k]

        end
    end
    return b
end
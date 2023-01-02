using SparseArrays

function loadMatrix(name)
    matrix = 0
    n = 0
    l = 0
    open(name, "r") do file
        header = split(readline(file), " ")
        n = parse(Int, header[1])
        l = parse(Int, header[2])
        elem_count = Int((n/l) * l^2 + n - l + ((n/l) - 1) * (2 * l -1) )

        I = Int[]
        J = Int[]
        V = Float64[]
        I = append!(I,zeros(Int,elem_count))
        J = append!(J, zeros(Int,elem_count))
        V = append!(V, zeros(Float64,elem_count))
        
        for k in 1:n
            rowStart = max(1, k - l)
            rowEnd = min(k+l, n)
            for j in rowStart:rowEnd
                push!(I,k)
                push!(J,j)
                push!(V,0.0)
            end
        end
        s = length(I)
        @show s

        
        i = 1
        for line in eachline(file)
            item = split(line, " ")
            I[i] = parse(Int, item[1])
            J[i] = parse(Int, item[2])
            V[i] = parse(Float64, item[3])
            i += 1
        end


        matrix = sparse(I,J,V)
        
        transpose(transpose(matrix))
    end
    return (matrix, n, l)
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
    return vector
end

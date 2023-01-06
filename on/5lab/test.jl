include("matrixSolver.jl")
include("reader.jl")
include("matrixgen.jl")

using Statistics
using .blocksys
using Plots
using .matrixgen

function twoStepLU(A,b)
    decompA = LU(A)
    return solveLU(decompA,b)
end

function twoStepPivotLU(A,b)
    decompA = pivotLU(A)
    return solvePivotLU(decompA,b)
end

function saveX(x, filename)
    open(filename, "w") do f
        for i in x
            println(f,i)
        end
    end
end

function saveX(x, filename, error)
    open(filename, "w") do f
        println(error)
        for i in x
            println(f,i)
        end
    end
end

function testFromFile(A,filename_b, func, output_name="output.txt")
    b = loadMatrix(filename_b)
    x = func(A,b)
    saveX(x, output_name)
end

function testGivenX(A, func, output_name="output.txt")
    x = ones(Float64,A[2])
    b = multiply(A,x)
    x_p = func(A,b)
    error = sum(map(abs,x-x_p))/sum(map(abs,x))
    saveX(x_p, output_name ,error)
end

function makeTimePlot(func, plotname)
    range = 1000:1000:100000
    time_measures = []
    for n in range
        blockmat(n,4,1.0, "test/genMat.txt")
        A = loadMatrix("test/genMat.txt")
        x = ones(Float64,n)
        b = multiply(A,x)
        stats = @timed x_p = func(A,b)
        push!(time_measures,stats.time)
        # println(stats.time)

    end
    plot(collect(range),time_measures, label=plotname)
    png("plots/time" * plotname)
end

function makeErrorPlot(func, plotname)
    range = 1000:1000:100000
    time_measures = []
    for n in range
        blockmat(n,4,1.0, "test/genMat.txt")
        A = loadMatrix("test/genMat.txt")
        x = ones(Float64,n)
        b = multiply(A,x)
        stats = @timed x_p = func(A,b)
        error = sum(map(abs,x-x_p))/sum(map(abs,x))
        push!(time_measures,error)
        println(error)

    end
    
    plot(collect(range),time_measures, label=plotname)
    png("plots/error" * plotname )
end

A = loadMatrix("test/Dane16_1_1/A.txt")

testGivenX(A, twoStepLU)
testGivenX(A, twoStepPivotLU)
testGivenX(A, gauss)
testGivenX(A, pivotGauss)

makeTimePlot(pivotGauss,"pivotGauss")
makeTimePlot(gauss,"Gauss")
makeTimePlot(twoStepLU,"LU")
makeTimePlot(twoStepPivotLU,"PivotLU")

makeErrorPlot(pivotGauss,"pivotGauss")
makeErrorPlot(gauss,"Gauss")
makeErrorPlot(twoStepLU,"LU")
makeErrorPlot(twoStepPivotLU,"PivotLU")

# makeErrorPlot(gauss)

println("testy czasu z czytanym b")
for n in [16,10000,50000,100000,300000,500000]
    println(n)
    A = loadMatrix("test/Dane"* string(n) * "_1_1/A.txt")
    b = loadVector("test/Dane"* string(n) * "_1_1/b.txt")
    @time gauss(A,b)
    @time pivotGauss(A,b)
    @time twoStepLU(A,b)
    @time twoStepPivotLU(A,b)
end

println("testy błędu z czytanym b")
for n in [16,10000,50000,100000,300000,500000]
    println(n)
    A = loadMatrix("test/Dane"* string(n) * "_1_1/A.txt")
    b = loadVector("test/Dane"* string(n) * "_1_1/b.txt")
    x = ones(Float64,A[2])
    
    println(sum(map(abs,x-gauss(A,b)))/sum(map(abs,x)) )
    println(sum(map(abs,x-pivotGauss(A,b)))/sum(map(abs,x)) )
    println(sum(map(abs,x-twoStepLU(A,b)))/sum(map(abs,x)) )
    println(sum(map(abs,x-twoStepPivotLU(A,b)))/sum(map(abs,x)) )

end

# A = loadMatrix("test/Dane500000_1_1/A.txt")

# testGivenX(A, twoStepLU)
# testGivenX(A, twoStepPivotLU)
# testGivenX(A, gauss)
# testGivenX(A, pivotGauss)



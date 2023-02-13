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
    range = 5000:5000:100000
    time_measures = []
    
    for n in range
        avg = []
        for k in 1:10
            blockmat(n,4,1.0, "test/genMat.txt")
            A = loadMatrix("test/genMat.txt")
            x = ones(Float64,n)
            b = multiply(A,x)
            stats = @timed x_p = func(A,b)
            push!(avg,stats.time)
        end
        push!(time_measures,mean(avg))
        # println(stats.time)

    end
    plot(collect(range),time_measures, label=plotname)
    png("plots/time" * plotname)
    return time_measures
end

function makeErrorPlot(func, plotname)
    range = 1.0:5:100.0

    time_measures = []
    n = 100000
    for ck in range
        blockmat(n,4,ck, "test/genMat.txt")
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
    return time_measures
end


function makeMemoryPlot(func, plotname)
    range = 5000:5000:100000
    time_measures = []
    for n in range
        avg = []
        for k in 1:2
            blockmat(n,4,1.0, "test/genMat.txt")
            A = loadMatrix("test/genMat.txt")
            x = ones(Float64,n)
            b = multiply(A,x)
            stats = @timed x_p = func(A,b)
            push!(avg,stats.bytes)
        end
        push!(time_measures,mean(avg))
        # println(stats.time)

    end
    plot(collect(range),time_measures, label=plotname)
    png("plots/memory" * plotname)
    return time_measures
end

Atest = loadMatrix("test/Dane16_1_1/A.txt")

testGivenX(Atest, twoStepLU)
testGivenX(Atest, twoStepPivotLU)
testGivenX(Atest, gauss)
testGivenX(Atest, pivotGauss)

# pg_time = makeTimePlot(pivotGauss,"pivotGauss")
# g_time =  makeTimePlot(gauss,"Gauss")
# lu_time = makeTimePlot(twoStepLU,"LU")
# pivotlu_time = makeTimePlot(twoStepPivotLU,"PivotLU")

# plot(collect(5000:5000:100000),pg_time, label="pivotGauss")
# plot!(collect(5000:5000:100000),g_time, label="Gauss")
# plot!(collect(5000:5000:100000),lu_time, label="LU")
# plot!(collect(5000:5000:100000),pivotlu_time, label="pivotLU")
# png("timecollected")


# pg_error = makeErrorPlot(pivotGauss,"pivotGauss")
# g_error =  makeErrorPlot(gauss,"Gauss")
# lu_error = makeErrorPlot(twoStepLU,"LU")
# pivotlu_error = makeErrorPlot(twoStepPivotLU,"PivotLU")
# range = 1.0:5:100.0
# plot(collect(range),pg_error, label="pivotGauss")
# plot!(collect(range),g_error, label="Gauss")
# plot!(collect(range),lu_error, label="LU")
# plot!(collect(range),pivotlu_error, label="pivotLU")
# png("errorcollected")

pg_mem = makeMemoryPlot(pivotGauss,"pivotGauss")
g_mem =  makeMemoryPlot(gauss,"Gauss")
lu_mem = makeMemoryPlot(twoStepLU,"LU")
pivotlu_mem = makeMemoryPlot(twoStepPivotLU,"PivotLU")

plot(collect(5000:5000:100000),pg_mem, label="pivotGauss")
plot!(collect(5000:5000:100000),g_mem, label="Gauss")
plot!(collect(5000:5000:100000),lu_mem, label="LU")
plot!(collect(5000:5000:100000),pivotlu_mem, label="pivotLU")
png("memorycollected")


# plot(collect(5000:5000:100000),[pg_time,g_time,lu_time,pivotlu_time], label=["pivotGauss", "Gauss", "Lu"])
# makeErrorPlot(pivotGauss,"pivotGauss")
# makeErrorPlot(gauss,"Gauss")
# makeErrorPlot(twoStepLU,"LU")
# makeErrorPlot(twoStepPivotLU,"PivotLU")

makeMemoryPlot(pivotGauss,"pivotGauss")
makeMemoryPlot(gauss,"Gauss")
makeMemoryPlot(twoStepLU,"LU")
makeMemoryPlot(twoStepPivotLU,"PivotLU")

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



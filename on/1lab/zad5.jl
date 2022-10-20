Ty = Float32

x = [Ty(2.718281828), Ty(-3.141592654), Ty(1.414213562), Ty(0.5772156649), Ty(0.3010299957)]
y =  [Ty(1486.2497), Ty(878366.9879), Ty(-22.37492), Ty(4773714.647), Ty(0.000185049)]
z = [0.,0.,0.,0.,0.]
for i in 1:5
    z[i] = x[i]*y[i]
end
@show(z)


function sum1(z,T)
    sum::T = 0.0
    for i in 1:size(z)[1]
        sum+=z[i]
    end
    return sum
end

function sum2(z,T)
    sum::T = 0.0
    s = size(z)[1]
    for i in 1:s
        sum+=z[s - i + 1]
    end
    return sum
end

function sum3(z,T)
    sump::T = 0.0
    sumn::T = 0.0
    sort!(z)
    # @show(z)
    i = 1
    while i < size(z)[1] && z[i] < 0 
        sumn += z[i]
        # @show(sumn)
        i+=1
    end
    i = size(z)[1]
    while i > 0 && z[i] > 0 
        sump += z[i]
        # @show(sump)
        i-=1
    end
    return sump  + sumn
end

function sum4(z,T)
    sump::T = 0.0
    sumn::T = 0.0
    sort!(z)
    # show(z)
    i = 1
    while i  <  size(z)[1] && z[i] < 0 
        i+=1
    end
    
    for k in 1:(i-1)
        sumn += z[k]
    end
    for k in i:size(z)[1]
        sump += z[k]
    end
    return sump  + sumn
end

println(sum1(z,Float32))
println(sum1(z,Float64))
println(sum2(z,Float32))
println(sum2(z,Float64))
println(sum3(z,Float32))
println(sum3(z,Float64))
println(sum4(z,Float32))
println(sum4(z,Float64))
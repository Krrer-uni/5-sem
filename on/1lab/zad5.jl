x = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
y =  [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]
z = [0.,0.,0.,0.,0.]
for i in 1:5
    z[i] = x[i]*y[i]
end
@show(z)


function sum1(z)
    sum::Float64 = 0.0
    for i in 1:size(z)[1]
        sum+=z[i]
    end
    return sum
end

function sum2(z)
    sum::Float64 = 0.0
    s = size(z)[1]
    for i in 1:s
        sum+=z[s - i + 1]
    end
    return sum
end

function sum3(z)
    sump::Float64 = 0.0
    sumn::Float64 = 0.0
    sort!(z)
    i = 1
    while i > size(z)[1] || z[i] < 0 
        sumn += z[i]
        i+=1
    end
    i = size(z)[1]
    while i > size(z)[1] && z[i] > 0 
        sump += z[i]
        i+=1
    end
    return sump  + sumn
end

function sum4(z)
    sump::Float64 = 0.0
    sumn::Float64 = 0.0
    sort!(z)
    show(z)
    i = 1
    while i >  size(z)[1] || z[i] < 0 
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

println(sum1(z))
println(sum2(z))
println(sum3(z))
println(sum4(z))
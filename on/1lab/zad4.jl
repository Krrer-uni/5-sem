# by Wojciech Rymer

function finddif()
    x::Float64 = nextfloat(1.0)
    while x != Float64(2.0)
        if Float64(x * Float64(Float64(1.0) / x)) != Float64(1.0)
            println(x)
            break
        end
        x = nextfloat(x)
    end
end
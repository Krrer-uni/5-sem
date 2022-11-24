# Wojciech Rymer
using Printf
using Plots

function normal_iter(r,p_0)
    f(x) = x^2 + r
    g(x) = x
    x(x) = 0
    plot([0],[0])
    x_min = -2
    x_max = 2
    plot(x, x_min,x_max,label = "")
    plot!(g, x_min,x_max,label = "y=x")
    plot!(f, x_min,x_max,label = "y=x^2 + c")
    p(x) = x*x +  r
    sol = zeros(40)
    sol[1] = p(p_0)
    points_x = [p_0,p_0]
    points_y = [0,f(p_0)]
    append!(points_x,sol[1],sol[1])
    append!(points_y,sol[1],f(sol[1]))
    for i in 2:40
        sol[i] = p(sol[i-1])
        append!(points_x,sol[i],sol[i])
        append!(points_y,sol[i],f(sol[i]))
    end
    plot!(points_x,points_y,label = "")
    # scatter!(points_x,points_y,label = "")
    png("test$r,$p_0")
    return sol
end

a1 = normal_iter(-2.0,1.0)
a2 = normal_iter(-2.0,2.0)
a3 = normal_iter(-2.0,1.99999999999999)
b1 = normal_iter(-1.0,1.0)
b2 = normal_iter(-1.0,-1.0)
b3 = normal_iter(-1.0,0.75)
b4 = normal_iter(-1.0,0.25)
# plot([1:40],a1,label = "c = -2, x = 1")
# plot!([1:40],a2,label = "c = -2, x = 2")
# plot!([1:40],a3,label = "c = -2, x = 1.99...")
# png("c2.png")
# plot([1:40],b1,label = "c = -1, x = 1")
# plot!([1:40],b2,label = "c = -1, x = -1")  
# png("c1.png")                                                                                                                                           
# plot([1:40],b3,label = "c = -1, x = 0.75")
# plot!([1:40],b4,label = "c = -1, x = 0.25")
# png("c1.2.png")

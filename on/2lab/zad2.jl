# Wojciech Rymer
using Plots


function plotf()
    f(x) = exp(x)*log(1 + exp(-x))
    plot(f,-100,100, label = "f")
end

plotf()
png("gloablyjl.png")
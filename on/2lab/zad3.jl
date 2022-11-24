# Wojciech Rymer

using LinearAlgebra
using Printf
function hilb(n::Int)
# Function generates the Hilbert matrix  A of size n,
#  A (i, j) = 1 / (i + j - 1)
# Inputs:
#	n: size of matrix A, n>=1
#
#
# Usage: hilb(10)
#
# Pawel Zielinski
        if n < 1
            error("size n should be >= 1")
        end
        return [1 / (i + j - 1) for i in 1:n, j in 1:n]
end

function matcond(n::Int, c::Float64)
# Function generates a random square matrix A of size n with
# a given condition number c.
# Inputs:
#	n: size of matrix A, n>1
#	c: condition of matrix A, c>= 1.0
#
# Usage: matcond(10, 100.0)
#
# Pawel Zielinski
        if n < 2
         error("size n should be > 1")
        end
        if c< 1.0
         error("condition number  c of a matrix  should be >= 1.0")
        end
        (U,S,V)=svd(rand(n,n))
        return U*diagm(0 =>[LinRange(1.0,c,n);])*V'
end

function hilbert(n)
        A = hilb(n)
        x = ones(n,1)
        b = A*x
        
        gauss = A\b
        inverse = inv(A)*b
        
        return @printf("%d,%d,%.3e,%.5e,%.5e\n",n,rank(A),cond(A),norm(gauss-x)/norm(x),norm(inverse-x)/norm(x))
end

function randommat(n,c)
        A = matcond(n,c)
        x = ones(n,1)
        b = A*x

        gauss = A\b
        inverse = inv(A)*b

        return @printf("%d,%d,%.3e,%.5e,%.5e\n",n,rank(A),cond(A),norm(gauss-x)/norm(x),norm(inverse-x)/norm(x))
end


println("hilbert")
hilbert_n = 
for n in 5:5:50
        hilbert(n)
end


println("random")

for n in [5 10 20]
        for c in [1.0; 10.0 ;10.0^3 ;10.0^7 ;10.0^12; 10.0^16]
                randommat(n,c)
        end
end 
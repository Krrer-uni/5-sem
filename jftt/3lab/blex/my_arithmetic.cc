#include <stdio.h>

long int gfnorm(long int a, long int base){
    while(a<0){
        a += base;
    }
   return a%base;
}

long int gcdExtended(long int a, long int b, long int* x, long int* y)
{
    // Base Case
    if (a == 0) {
        *x = 0;
        *y = 1;
        return b;
    }
 
    long int x1, y1; // To store results of recursive call
    long int gcd = gcdExtended(b % a, a, &x1, &y1);
 
    // Update x and y using results of recursive
    // call
    *x = y1 - (b / a) * x1;
    *y = x1;
 
    return gcd;
}
 

long int gfinv(long int a, long int base){
    long int x = 0;
    long int y = 0;
    gcdExtended(base,a,&x,&y);
    return gfnorm(y,base);
}

long int gfadd(long int a, long int b, long int base){
    a = gfnorm(a,base);
    b = gfnorm(b,base);
    return gfnorm(a+b, base);
}
long int gfsub(long int a, long int b, long int base){
    a = gfnorm(a,base);
    b = gfnorm(b,base);
    return gfnorm(a-b, base);
}

long int gfmul(long int a, long int b, long int base){
    a = gfnorm(a,base);
    b = gfnorm(b,base);
    return gfnorm(a*b, base);
}

long int gfdiv(long int a, long int b, long int base){
    a = gfnorm(a,base);
    b = gfnorm(b,base);
    return gfmul(a,gfinv(b,base),base);
};

long int gfpow(long int a, long int b, long int base){
    gfnorm(a,base);
    long int res = 1;
    if(a == 0) return 0;
    // Check till the number becomes zero
    while (b > 0) {
 
        if (b % 2 == 1){
            res = gfnorm((res * a),base);
        }
 
        b = b >> 1;

        a = gfnorm((a * a),base);
        // printf("%ld %ld\n",res,a);
    }
    return res;
};
#include <float.h>
#include <stdio.h>
int main(){
    printf("float%d machine epsilon in c %.22e\n",sizeof(float) * 8, FLT_EPSILON);
    printf("float%d machine epsilon in c %.22e\n",sizeof(double) * 8, DBL_EPSILON);
    printf("float%d machine epsilon in c %.22e\n",sizeof(long double) * 8, LDBL_EPSILON);
    printf("floatmax = %.6e \n %.6e", FLT_MAX , DBL_MAX);
}
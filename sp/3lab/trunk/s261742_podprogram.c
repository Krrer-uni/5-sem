#include "program.h"
#define M_PI 3.14159265358979323846

void s261742_podprogram(){
    printf("Wojciech Rymer, 261742 program liczący objętość kuli o zadanym promieniu\n");
    long double sphere_r = 1.0;
    printf("Podaj promień kuli:\n");
    scanf("%Lf",&sphere_r);
    long double sphere_V = 4.0/3.0 * M_PI * sphere_r * sphere_r * sphere_r;
    printf("Kula o promieniu %Lf ma objętość %Lf\n", sphere_r, sphere_V);
}
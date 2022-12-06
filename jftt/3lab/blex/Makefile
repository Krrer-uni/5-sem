FLAGS =

CC = gcc

.PHONY = all clean cleanall

all: calc

calc: calc.y calc.l my_arithmetic.c calc.cpp
	bison -o calc_y.c -d calc.y -Wcounterexamples
	flex -o calc_l.c -d calc.l
	$(CC) $(FLAGS) -o calc calc_y.c calc_l.c my_arithmetic.c 


clean:
	rm -f *.c *.h
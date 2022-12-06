FLAGS = -std=c++17

CC = g++

.PHONY = all clean cleanall

all: calc

calc: calc.y calc.l my_arithmetic.cc calc.cpp
	bison -o calc_y.cc -d calc.y -Wcounterexamples
	flex -o calc_l.cc -d calc.l
	$(CC) $(FLAGS) -o calc calc_y.cc calc_l.cc my_arithmetic.cc 


clean:
	rm -f *.c *.h
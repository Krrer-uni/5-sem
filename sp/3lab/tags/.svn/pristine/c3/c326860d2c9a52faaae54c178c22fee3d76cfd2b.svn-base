objects = main.o program_usage.o \
          s0_podprogram.o \
          s999_podprogram.o \
		  s254648_podprogram.o \
		  s261737_podprogram.o \
		  s261744_podprogram.o \
		  s261742_podprogram.o

program : $(objects)
	cc -o program $(objects)
main.o : program.h

program_usage.o : program.h

s0_podprogram.o : program.h

s999_podprogram.o : program.h

s261737_podprogram.o : program.h

s261744_podprogram.o : program.h

s261742_podprogram.o : program.h

.PHONY : clean

clean : 
	-rm *.o program


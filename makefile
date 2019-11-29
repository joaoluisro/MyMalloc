all:
	as test.s -o test.o
	ld test.o -o test
clean:
	rm	*.o
	rm	test

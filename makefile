all:
	as test.s -o test.o
	ld test.o -o test
clean:
	rm -rf	*.o
	rm -rf	test

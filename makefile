all:
	cd malloc_v1; gcc malloc_v1.c malloc_v1.s -o malloc_v1 -w
clean:
	find . -name '*.o' -type f -delete

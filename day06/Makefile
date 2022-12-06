all: solve

solve: solve.o
	clang -no-pie solve.o -o solve     
solve.o: solve.ll
	llc -filetype=obj solve.ll


.PHONY: clean
clean:
	rm -f solve solve.o solve.s
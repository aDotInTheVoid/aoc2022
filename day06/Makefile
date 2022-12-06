MAKEFLAGS += --no-builtin-rules

all: solve_q1

%: %.o
	clang -no-pie $< -o $@     
%.o: %.ll
	llc -filetype=obj $< -o $@

%.s: %.ll
	llc -filetype=asm $< -o $@

%_opt.ll: %.ll
	opt -passes='default<O3>' -S $< -o $@

.PHONY: clean
clean:
	rm -f solve solve.o solve.s *opt*
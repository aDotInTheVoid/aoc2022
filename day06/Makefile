MAKEFLAGS += --no-builtin-rules

all: solve_q1

%: %.o
	clang -no-pie $< -o $@     
%.o: %.ll
	llc -filetype=obj -O0 --debugify-level=location+variables    $< -o $@

%.s: %.ll
	llc -filetype=asm $< -o $@

%_opt.ll: %.ll
	opt -passes='default<O3>' -S $< -o $@

.PHONY: clean
clean:
	rm -f solve_q1 solve_q2 *.o *.s *opt*
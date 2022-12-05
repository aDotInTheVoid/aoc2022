# gawk -f solve.awk input.txt
BEGIN {
	FS="\n";
}

/^$/ {
	FS=" ";
}

/\[/ {
	n_blocks = (length($1)+1)/4;
	print n_blocks;
	for (i = 1; i <= n_blocks; i++) {
		print substr($1, i*4 - 2, 1);
	}
}

/move/ {
	move = $2
	from = $2;
	to   = $4;

	print "Moving ", move, " from ", from, " to ", to;
}

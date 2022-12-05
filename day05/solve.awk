# gawk -f solve.awk input.txt
BEGIN {
	FS="\n";
	bline = 1;
}

/^$/ {
	FS=" ";
	print_grid(grid1);
}

function push(A,B) { A[length(A)+1] = B }
function print_grid(g) {
		for (pgi in g) {
			for (pgj in g[pgi]) {
				printf "%s", g[pgi][pgj];
			}
			print "";
		}
	}

/\[/ {
	n_blocks = (length($1)+1)/4;
	if (bline == 1){
		while (bline < 100) {
			for (i=1;i<=n_blocks;i++)
				grid1[bline][i] = " ";
			bline++;
		}
	}

	for (i = 1; i <= n_blocks; i++) {
		grid1[bline][i] = substr($1, i*4 - 2, 1);
	}
	bline++;
}



function move1(g, from, to) {
	for (bl in g) {
		c = g[bl][from];
		if (c ~ /[A-Z]/) {
			g[bl][from] = " ";
			break;
		}
	}
	
	off = 0;
	for (bl in g) {
		c2 = g[bl][to];
		if (c2 ~ /[A-Z]/) {
			off = -1;
			break;
		}
	}

	print "bl=",bl;
	print "Moving", c, "to", (bl-1), ";"
	g[bl+off][to]=c;
	print_grid(g);
}



/move/ {
	move = $2
	from = $4;
	to   = $6;

	print "Moving ", move, " from ", from, " to ", to;
	for (i2 = 1; i2 <= move; i2++) {
		move1(grid1, from, to);
	}
	print "\n\n";


    q1 = "";
	for (i=1;i<=n_blocks;i++) {
		for (bl in grid1) {
			c = grid1[bl][i];
			if (c ~ /[A-Z]/) {
				q1 = q1 c;
				break;
			}
		}
	}
	print "q1=", q1; # BWNCQRMDB

}

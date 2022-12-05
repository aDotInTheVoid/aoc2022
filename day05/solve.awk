# gawk -f solve.awk input.txt
BEGIN {
	FS="\n";
	bline = 1;
}

/^$/ { FS=" "; }


/\[/ {
	n_blocks = (length($1)+1)/4;
	if (bline == 1){
		while (bline < 100) {
			for (i=1;i<=n_blocks;i++) {
				grid1[bline][i] = " ";
				grid2[bline][i] = " ";
			}
			bline++;
		}
	}

	for (i = 1; i <= n_blocks; i++) {
		c = substr($1, i*4 - 2, 1);
		grid1[bline][i] = c;
		grid2[bline][i] = c;
	}
	bline++;
}

/move/ {
	move = $2
	from = $4;
	to   = $6;

	for (i2 = 1; i2 <= move; i2++)
		move1(grid1, from, to);

	move2(grid2, from, to, move);
}

END {
	q1 = "";
	q2 = "";
	for (i=1;i<=n_blocks;i++) {
		for (bl in grid1) {
			c = grid1[bl][i];
			if (c ~ /[A-Z]/) {
				q1 = q1 c;
				break;
			}
		}
		for (bl in grid2) {
			c = grid2[bl][i];
			if (c ~ /[A-Z]/) {
				q2 = q2 c;
				break;
			}
		}
	}
	print "q1=", q1; # BWNCQRMDB
	print "q2=", q2; # NHWZCBNBF
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
		if (g[bl][to] ~ /[A-Z]/) {
			off = -1;
			break;
		}
	}

	g[bl+off][to]=c;
}

function move2(g, from, to, n) {
	off = -1;
	for (to_i in g) {
		c = g[to_i][to];
		if (c ~ /[A-Z]/) {off=0;break;}
	}
	to_i -= n+off;
	for (from_i in g) {
		if (g[from_i][from] ~ /[A-Z]/) break;
	}
	for (i = 0; i<n; i++) {
		g[to_i+i][to] = g[from_i+i][from];
		g[from_i+i][from] = " ";
	}
}

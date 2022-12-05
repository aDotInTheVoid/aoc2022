input <- readLines("input.txt")

sc1 <- 0
sc2 <- 0

for (i in 1:length(input)) {
    intervals <- strsplit(input[i], ",")[[1]] 

    i1 <- strsplit(intervals[1], "-")[[1]]
    i2 <- strsplit(intervals[2], "-")[[1]]

    i1_lo <- as.numeric(i1[1])
    i1_hi <- as.numeric(i1[2])
    i2_lo <- as.numeric(i2[1])
    i2_hi <- as.numeric(i2[2])

    if (i1_lo <= i2_lo && i1_hi >= i2_hi) {
        sc1 <- sc1 + 1
    } else if (i2_lo <= i1_lo && i2_hi >= i1_hi) {
        sc1 <- sc1 + 1
    }

    if (i1_lo <= i2_hi && i2_lo <= i1_hi) {
        sc2 <- sc2 + 1
    }
}

print(sc1) # 573
print(sc2) # 867
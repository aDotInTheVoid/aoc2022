#!/bin/bash
set -eou pipefail

./gen.bash > mkfs.bash
./mkfs.bash

q1sum=0

rm -rf sizes.txt

for dirname in $(find tmp -type d)
do
    sum=0
    for filename in $(find $dirname -type f)
    do
        n=$(cat $filename)
        sum=$((sum + n))
    done
    echo $dirname $sum >> sizes.txt

    if [[ $sum -lt 100001 ]]
    then
        q1sum=$((q1sum + sum))
    fi

done

echo "Q1: $q1sum"

sort sizes.txt -k 2 -n > szsort.txt

totsz=$(tail -n1 szsort.txt | cut -d' ' -f2)
needed=$((totsz - 40000000))

echo $needed

cat szsort.txt | while IFS= read -r dat
do
    sz=$(cut -d' ' -f2 <<< $dat)
    if [[ $sz -ge $needed ]] # 
    then
        echo "Q2: $sz"
        break
    fi
done

# rm sizes.txt
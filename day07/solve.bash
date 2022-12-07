#!/bin/bash
set -eou pipefail

rm -rf ./tmp ./mkfs.bash ./sizes.txt ./szsort.txt
mkdir tmp

echo "#!/bin/bash" >> mkfs.bash
echo "set -eou pipefail" >> mkfs.bash

while read p; do
  if [[ $p =~ "\$ cd" ]]; then
    p=${p/\$ /}
    echo ${p/\//tmp} >> mkfs.bash
  elif [[ $p =~ "dir" ]]; then
    echo "mkdir ${p/dir /}" >> mkfs.bash
  elif [[ $p =~ " ls" ]]; then 
    :
  else
    sz=$(cut -d' ' -f1 <<< $p)
    name=$(cut -d' ' -f2 <<< $p)
    echo "echo $sz > $name" >> mkfs.bash
  fi
done <input.txt

chmod +x mkfs.bash
./mkfs.bash

q1sum=0
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

cat szsort.txt | while IFS= read -r dat
do
    sz=$(cut -d' ' -f2 <<< $dat)
    if [[ $sz -ge $needed ]] # 
    then
        echo "Q2: $sz"
        break
    fi
done

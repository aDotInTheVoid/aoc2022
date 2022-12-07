#!/bin/bash
set -eou pipefail

echo "#!/bin/bash"
echo "set -eou pipefail"
echo "rm -rf tmp"
echo "mkdir tmp"

while read p; do
  if [[ $p =~ "\$ cd" ]]
  then
    p=${p/\$ /}
    p=${p/\//tmp}
    echo $p
  elif [[ $p =~ "dir" ]]
  then
    p=${p/dir /}
    echo "mkdir $p"
  elif [[ $p =~ " ls" ]]
  then
    echo ""
  else
    sz=$(cut -d' ' -f1 <<< $p)
    name=$(cut -d' ' -f2 <<< $p)
    echo "echo $sz > $name"
  fi
done <input.txt
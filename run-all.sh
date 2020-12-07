set -eux

BASE=$(pwd)

for i in ds[1-8]; do
    (cd $i && ../run-ds.sh &)
done

set -eux

BASE=$(pwd)

for i in ds1 ds[3-8]; do
    (cd $i && ../run-ds.sh)
done

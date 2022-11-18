set -eux

BASE=$(pwd)

for i in ds1 ds[3-8]; do
    (cd $i && ../run-ds-perpcsp-convg.sh)
done

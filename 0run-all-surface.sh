set -eux

BASE=$(pwd)
STEPS=100

for i in ds1 ds[3-8]; do
    (cd $i && ../run-ds-llh-surface.sh $STEPS)
done

set -eux

BASE=$(pwd)
DSOUTPATH=_golden_benchmark_output
AGGOUTPATH=_golden_benchmark_results

rm -rf $AGGOUTPATH
mkdir -p $AGGOUTPATH
cp -r vbpi_exp $AGGOUTPATH/vbpi

for i in ds1 ds3 ds4 ds5 ds6 ds7 ds8; do
    (cd $i && bash $BASE/run-ds-benchmark-golden.sh $i)
    cp $i/$DSOUTPATH/$i.bench* $AGGOUTPATH/.
done

gpb coverage $AGGOUTPATH

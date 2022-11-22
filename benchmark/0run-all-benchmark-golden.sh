set -eux

BASE=$(pwd)
DSOUTPATH=_golden_benchmark_output
AGGOUTPATH=_golden_benchmark_results

rm -rf $AGGOUTPATH
mkdir -p $AGGOUTPATH

for i in ds1 ds{3..8}; do
    (cd ../$i && bash $BASE/run-ds-benchmark-golden.sh $i)
    cp ../$i/$DSOUTPATH/$i.bench* $AGGOUTPATH/.
done

conda run -n bito gpb coverage $AGGOUTPATH
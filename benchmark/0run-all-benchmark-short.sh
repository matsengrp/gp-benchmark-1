set -eux

BASE=$(pwd)

rm -rf _benchmark_results
mkdir -p _benchmark_results

for i in ds1 ds3 ds4 ds5 ds6 ds7 ds8; do
    (cd ../$i && conda run -n bito ../benchmark/run-ds-benchmark-short.sh)
    cp ../$i/_benchmark_output/$i.bench* _benchmark_results/.
done

conda run -n bito gpb coverage _benchmark_results

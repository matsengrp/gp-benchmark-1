#!/bin/bash

set -eu -o pipefail

DS=$1
GOLDENRUNPATH=/fh/fast/matsen_e/shared/vip/ds-golden/$DS/_exp_output
OUTPATH=_golden_benchmark_output

rm -rf $OUTPATH; mkdir $OUTPATH; cp $GOLDENRUNPATH/$DS.t $OUTPATH/.
rm -f _$OUTPATH/0sentinel

# appending base.json with objects for per pcsp convergence
jq '. +{"use_gradients":0, "intermediate":0, "hotstart":0, "steps":0, "benchmark_iters":10}' base.json >benchmark.json

gpb template config.json benchmark.json $OUTPATH/config.json

cd $OUTPATH

gpb template --make-paths-absolute --mb basic.mb config.json run.mb

for i in prep-gp-benchmark.sh benchmark.sh; do
    gpb template --make-paths-absolute --mb $i config.json $i
done

#mb run.mb | tee mb.log
bash prep-gp-benchmark.sh
bash benchmark.sh | tee benchmark.log

touch 0sentinel

#!/bin/bash

set -eu -o pipefail

# Because data is already in _output, we will copy  so results are stored in separate directories
# mkdir -p _output

OUTPATH=_benchmark_output

rm -rf $OUTPATH; cp -r _output $OUTPATH
rm -f _$OUTPATH/0sentinel

# appending base.json with objects for per pcsp convergence
jq '. +{"use_gradients":0, "intermediate":0, "hotstart":0, "steps":0}' base.json >benchmark.json

gpb template config.json benchmark.json $OUTPATH/config.json

cd $OUTPATH

gpb template --make-paths-absolute --mb basic.mb config.json run.mb

for i in prep-gp-bl.sh benchmark.sh; do
    gpb template --make-paths-absolute --mb $i config.json $i
done

#mb run.mb | tee mb.log
bash prep-gp-bl.sh
bash benchmark.sh | tee benchmark.log

touch 0sentinel

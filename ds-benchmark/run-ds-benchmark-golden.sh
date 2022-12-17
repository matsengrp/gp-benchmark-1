#!/bin/bash

set -eu -o pipefail

ds=$1
OUTPATH=_golden_benchmark_output
UNIFTREEPATH=MrBayes/unif
EXPTREEPATH=MrBayes/exp

gunzip -c $UNIFTREEPATH/$ds.t.tar.gz > $UNIFTREEPATH/$ds.t 
gunzip -c $EXPTREEPATH/$ds.t.tar.gz > $EXPTREEPATH/$ds.t 

rm -rf $OUTPATH; mkdir $OUTPATH; 
rm -f _$OUTPATH/0sentinel

gpb template config.json benchmark.json $OUTPATH/config.json

cd $OUTPATH

for i in prep-gp-benchmark.sh benchmark.sh; do
    gpb template --make-paths-absolute --mb $i config.json $i
done

bash prep-gp-benchmark.sh
bash benchmark.sh | tee benchmark.log

touch 0sentinel

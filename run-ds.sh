#!/bin/bash

set -eu -o pipefail

mkdir -p _output
rm -f _output/0sentinel

gpb template config.json base.json _output/config.json

cd _output

gpb template --make-paths-absolute --mb basic.mb config.json run.mb

for i in prep-gp.sh fit.sh direct.sh; do
    gpb template --make-paths-absolute --mb $i config.json $i
done

#mb run.mb | tee mb.log
bash prep-gp.sh
bash fit.sh | tee fit.log
bash direct.sh | tee direct.log

touch 0sentinel

#!/bin/bash

set -eu -o pipefail

# Because data is already in _output, we will copy to _nograd_output and _grad_output, so results are stored in separate directories
# mkdir -p _output

cp -r _output _nograd_output
cp -r _output _grad_output
rm -f _output/0sentinel

gpb template config.json nograd_base.json _nograd_output/config.json
gpb template config.json grad_base.json _grad_output/config.json

cd _nograd_output

gpb template --make-paths-absolute --mb basic.mb config.json run.mb

for i in prep-gp.sh fit.sh outside.sh; do
    gpb template --make-paths-absolute --mb $i config.json $i
done

#mb run.mb | tee mb.log
bash prep-gp.sh
bash fit.sh | tee fit.log
# bash outside.sh | tee outside.log

# Now with gradients
cd ../_grad_output

gpb template --make-paths-absolute --mb basic.mb config.json run.mb

for i in prep-gp.sh fit.sh outside.sh; do
    gpb template --make-paths-absolute --mb $i config.json $i
done

#mb run.mb | tee mb.log
bash prep-gp.sh
bash fit.sh | tee fit.log
# bash outside.sh | tee outside.log

touch 0sentinel

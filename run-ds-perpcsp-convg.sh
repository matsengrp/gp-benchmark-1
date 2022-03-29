#!/bin/bash

set -eu -o pipefail

# Because data is already in _output, we will copy  so results are stored in separate directories
# mkdir -p _output

cp -r _output _fullhybridllh_output
cp -r _output _perpcspllh_output
rm -f _output/0sentinel

# appending base.json with objects for per pcsp convergence
jq '. +{"use_gradients":0, "per_pcsp_convg":0}' base.json >fullhybridllh.json
jq '. +{"use_gradients":1, "per_pcsp_convg":1}' base.json >perpcspllh.json

gpb template config.json fullhybridllh.json _fullhybridllh_output/config.json
gpb template config.json perpcspllh.json _perpcspllh_output/config.json

cd _fullhybridllh_output

gpb template --make-paths-absolute --mb basic.mb config.json run.mb

for i in prep-gp.sh fit.sh outside.sh; do
    gpb template --make-paths-absolute --mb $i config.json $i
done

#mb run.mb | tee mb.log
bash prep-gp.sh

bash fit.sh | tee fit.log
# bash outside.sh | tee outside.log

# Now with perpcsp likelihoods
cd ../_perpcspllh_output

gpb template --make-paths-absolute --mb basic.mb config.json run.mb

for i in prep-gp.sh fit.sh outside.sh; do
    gpb template --make-paths-absolute --mb $i config.json $i
done

#mb run.mb | tee mb.log
bash prep-gp.sh

bash fit.sh | tee fit.log
# bash outside.sh | tee outside.log

touch 0sentinel

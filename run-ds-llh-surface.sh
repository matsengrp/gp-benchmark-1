#!/bin/bash

set -eu -o pipefail

# mkdir -p _output

cp -r _output _llh_surface
rm -f _output/0sentinel

# appending nograd_base.json with objects for per pcsp convergence
jq --arg steps "$1" '. +={"use_gradients":0, "per_pcsp_convg":0, "steps":($steps|tonumber)}' base.json >surface.json

gpb template config.json surface.json _llh_surface/config.json

cd _llh_surface

gpb template --make-paths-absolute --mb basic.mb config.json run.mb

for i in prep-gp.sh fit.sh surface.sh; do
    gpb template --make-paths-absolute --mb $i config.json $i
done

#mb run.mb | tee mb.log
bash prep-gp.sh
bash fit.sh
bash surface.sh

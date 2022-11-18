#!/bin/bash

set -eu -o pipefail

if [ $2 == 0 ]; then
	OUT_PATH=_llh_surface_optimized_bl
	JSON_NAME=surface_optimized
else 
	OUT_PATH=_llh_surface_hotstart
	JSON_NAME=surface_hotstart
fi

rm -rf $OUT_PATH; cp -r _output $OUT_PATH

jq --arg steps "$1" --arg hotstart "$2" '. +={"use_gradients":0, "per_pcsp_convg":0, "steps":($steps|tonumber), "hotstart":($hotstart|tonumber)}' base.json >$JSON_NAME.json

gpb template config.json $JSON_NAME.json $OUT_PATH/config.json

cd $OUT_PATH

gpb template --make-paths-absolute --mb basic.mb config.json run.mb

for i in prep-gp.sh prep-gp-bl.sh fit.sh surface.sh; do
    gpb template --make-paths-absolute --mb $i config.json $i
done

#mb run.mb | tee mb.log
bash prep-gp.sh
bash prep-gp-bl.sh
bash fit.sh
bash surface.sh

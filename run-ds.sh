#!/bin/bash

set -eu -o pipefail

mkdir -p _output
rm -f _output/0sentinel

gpb template config.json base.json _output/config.json

cd _output

gpb template --make-paths-absolute --mb basic.mb config.json run.mb
gpb template --make-paths-absolute --mb prep-gp.sh config.json prep-gp.sh
gpb template --make-paths-absolute --mb fit.sh config.json fit.sh

mb run.mb | tee mb.log
bash prep-gp.sh
bash fit.sh | tee fit.log

touch 0sentinel

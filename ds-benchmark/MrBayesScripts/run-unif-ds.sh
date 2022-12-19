#!/bin/bash 

set -eu

for ds in 1 3 4 5 6 7 8;
do
    cd ../ds${ds}/MrBayes/unif
    mb run.mb | tee mb.log &
    cd ../../
done

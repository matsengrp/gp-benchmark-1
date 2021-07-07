#!/bin/bash

set -eu -o pipefail

csvstack ds[1-8]/_output/correlation.csv > correlation.csv

rm -f direct-correlation.csv

for i in ds*/_output/direct-correlation.csv; do
    echo -n $(echo $i | sed -e 's#/.*##'), >> direct-correlation.csv
    tail -n 1 $i >> direct-correlation.csv
done

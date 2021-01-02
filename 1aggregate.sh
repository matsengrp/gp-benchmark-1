#!/bin/bash

set -eu -o pipefail

csvstack ds[1-8]/_output/correlation.csv > correlation.csv

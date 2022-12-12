#!/bin/bash

set -eu -o pipefail

TREES=Makona_1610_genomes_2016-06-23_unique_sequences.fasta.ufboot.rerooted.sorted.top1000
SEQS=Makona_1610_genomes_2016-06-23_unique_sequences.fasta

mkdir -p _ignore
test -f _ignore/$TREES || gunzip -c $TREES.gz > _ignore/$TREES
test -f _ignore/$SEQS || gunzip -c $SEQS.gz > _ignore/$SEQS

rm -r _output
mkdir _output
cd _output

mmap=/loc/scratch/mmap.dat

trap "rm -f $mmap" EXIT

SECONDS=0

gpb fit --config ../config.json ../_ignore/$TREES ../_ignore/$SEQS makona 

duration=$SECONDS

echo "GP on makona took a total of $(($duration / 60)) minutes and $(($duration % 60)) seconds."

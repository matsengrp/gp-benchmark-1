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

for i in prep-gp.sh prep-gp-singletree.sh fit.sh outside.sh single-tree-fit.sh; do
    gpb template --make-paths-absolute --mb $i config.json $i
done

#mb run.mb | tee mb.log
bash prep-gp.sh
bash prep-gp-singletree.sh
declare -i NTREES=3 #$(wc -l < rerooted-topologies.noburnin.nonsingletons.nwk)
# bash fit.sh | tee fit.log
bash single-tree-fit.sh | tee single-tree-fit.log
# bash outside.sh | tee outside.log

# Now with gradients
cd ../_grad_output

gpb template --make-paths-absolute --mb basic.mb config.json run.mb

for i in prep-gp.sh prep-gp-singletree.sh fit.sh outside.sh single-tree-fit.sh; do
    gpb template --make-paths-absolute --mb $i config.json $i
done

#mb run.mb | tee mb.log
bash prep-gp.sh
bash prep-gp-singletree.sh
# bash fit.sh | tee fit.log
bash single-tree-fit.sh | tee single-tree-fit.log
# bash outside.sh | tee outside.log

cd ..
rm -rf _single_tree_plots
mkdir _single_tree_plots

declare -i count=0
while [ $count -lt $NTREES ]; do
	nograd_surf=_nograd_output/gp.$count.perpcsp_llh_surface.csv
	nograd_track=_nograd_output/gp.$count.tracked_bl_correction.csv
	grad_surf=_grad_output/gp.$count.perpcsp_llh_surface.csv
	grad_track=_grad_output/gp.$count.tracked_bl_correction.csv
	out_path=_single_tree_plots/$count.perpcsp_plot.pdf
	gpb pcsptrackplot $nograd_surf $nograd_track $grad_surf $grad_track $out_path
	count+=1
done

touch 0sentinel

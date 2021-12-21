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

for i in prep-gp.sh prep-gp-mltree.sh fit.sh outside.sh ml-tree-fit.sh; do
    gpb template --make-paths-absolute --mb $i config.json $i
done

#mb run.mb | tee mb.log
bash prep-gp.sh
bash prep-gp-mltree.sh

# Below is code for single tree
# declare -i NTREES=3 #$(wc -l < rerooted-topologies.noburnin.nonmltons.nwk)

# bash fit.sh | tee fit.log
bash ml-tree-fit.sh | tee ml-tree-fit.log
# bash outside.sh | tee outside.log

# Now with gradients
cd ../_grad_output

gpb template --make-paths-absolute --mb basic.mb config.json run.mb

for i in prep-gp.sh prep-gp-mltree.sh fit.sh outside.sh ml-tree-fit.sh; do
    gpb template --make-paths-absolute --mb $i config.json $i
done

#mb run.mb | tee mb.log
bash prep-gp.sh
bash prep-gp-mltree.sh
# bash fit.sh | tee fit.log
bash ml-tree-fit.sh | tee ml-tree-fit.log
# bash outside.sh | tee outside.log

cd ..
rm -rf _ml_tree_plots
mkdir _ml_tree_plots

nograd_surf=_nograd_output/gp.ml.perpcsp_llh_surface.csv
nograd_track=_nograd_output/gp.ml.tracked_bl_correction.csv
grad_surf=_nograd_output/gp.ml.perpcsp_llh_surface.csv # it should be the same as nograd_surf
grad_track=_grad_output/gp.ml.tracked_bl_correction.csv
out_path=_ml_tree_plots/ml.perpcsp_plot.pdf
gpb pcsptrackplot $nograd_surf $nograd_track $grad_surf $grad_track $out_path

touch 0sentinel

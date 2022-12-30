# Generalized pruning benchmark repository

This repository is set up so people can reproduce the benchmarking results for the paper _A Generalized Phylogenetic Pruning Algorithm_ by Jun, Nasif, Jennings-Shaffer, Rich, Kooperberg, Fourment, Zhang, Suchard, and Matsen IV.

See the paper for data citations, and please cite the respective papers if you re-use the data.

### Prerequisites
- Install bito
  - https://github.com/phylovi/bito
- Install bito GP benchmark environment
  - https://github.com/matsengrp/gp-benchmark-1-environment
- Install Git Large File Storage (LFS) and retrieve DS test data files
  - `conda install -c conda-forge git-lfs && git lfs install`
  - `git lfs pull`

### Run DS Benchmark

#### MrBayes MCMC Posterior
- The MrBayes scripts to produce the posterior samples for each dataset are found in `ds-benchmark/MrBayesScripts`
  - There are two scripts used to sample from the posterior with either uniform or exponential prior on branch lengths.
  - To execute one of the scripts, such as with the uniform prior: `bash run-unif-ds.sh`
- MrBayes specifications and the posterior tree samples are located in the respective dataset directories found in `ds-benchmark/`
  - Git LFS is required to retrieve these data files.

#### Generalized Pruning benchmarking
- Location: `ds-benchmark/`
  - To run benchmark on all datasets: `conda activate bito && bash 0run-all-benchmark-golden.sh`
  - To run benchmark on all datasets through a SLURM job: `sbatch sbatch-run-all-golden.sh`
- Results are output to: `ds-benchmark/_golden_benchmark-results/`
  - A copy of this results output is saved in the directory `manuscript_results/`

#### VBPI Benchmarking
- Location: `ds-benchmark/vbpi-exp`
- See the following repository for instructions on reproducing these results:
  - https://github.com/matsengrp/vbpi-torch/tree/sample-trees

### Run Makona
- The Makona data estimation script is located in `makona-benchmark/`
  - To run the makona script: `conda activate bito && bash run-makona.sh`
- Results are output to: `makona-benchmark/_output`

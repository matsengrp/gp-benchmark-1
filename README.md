## Perform Bito GP Golden Run Benchmarking:
### Prerequisites
- Install bito  
  - https://github.com/phylovi/bito.git 
- Install bito GP benchmark environment
  - https://github.com/matsengrp/gp-benchmark-1-environment.git
### Run DS Benchmark
#### MrBayes MCMC Posterior
- The MrBayes scripts to produce the posterior samples for each dataset is found in `ds-benchmark/MrBayesScripts`
  - There are two scripts used to sample from the posterior with either uniform or exponential prior on branch lengths.
  - To execute one of the scripts, such as with the uniform prior: `bash run-unif-ds.sh`
- MrBayes specifications and the posterior tree samples are located in the respective dataset directories found in `ds-benchmark/` 
#### Generalized Pruning benchmarking
- The GP benchmark script is located: `ds-benchmark/`
  - To run benchmark on all datasets: `conda activate bito && bash 0run-all-benchmark-golden.sh`
  - To run benchmark on all datasets through slurm job: `sbatch sbatch-run-all-golden.sh`
- Results are outputted to: `ds-benchmark/_golden_benchmark-results/`
#### VBPI Benchmarking
- The VBPI benchmarking results is located: `ds-benchmark/vbpi-exp`
- See the following repository for instructions on reproducing these results:
  - https://github.com/matsengrp/vbpi-torch/tree/sample-trees.git
### Run Makona
- The makona estimation script is located in `makona-benchmark/`
  - To run the makona script: `conda activate bito && bash run-makona.sh`
- Results are outputted to: `makona-benchmark/_output` 

## Perform Bito GP Golden Run Benchmarking:
### Prerequisites
- Install bito  
  - https://github.com/phylovi/bito.git 
- Install bito GP benchmark environment
  - https://github.com/matsengrp/gp-benchmark-1-environment.git
### Run Benchmark
- The golden benchmark script is located: `ds-benchmark/`
  - To run benchmark on all datasets: `conda activate bito && bash 0run-all-benchmark-golden.sh`
  - To run benchmark on all datasets through slurm job: `sbatch sbatch-run-all-golden.sh`
- Results are outputted to: `ds-benchmark/_golden_benchmark-results/`
### Run Makona
- The makona estimation script is located in `makona/`
  - To run the makona script: `conda activate bito && bash run-makona.sh`
  - To run the makona script through a slurm job: `sbatch sbatch-run-makona.sh`
- Results are outputted to: `makona/_output` 

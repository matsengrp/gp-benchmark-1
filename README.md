## Perform Bito GP Golden Run Benchmarking:
### Prerequisites
- Install bito  
  - https://github.com/phylovi/bito.git 
- Install bito GP benchmark environment
  - https://github.com/matsengrp/gp-benchmark-1-environment.git
### Run Benchmark
- Golden benchmark script is located: `benchmark/`
  - To run benchmark on all datasets: `bash 0run-all-benchmark-golden.sh`
  - To run benchmark on all datasets through slurm job: `sbatch sbatch-run-all-golden.sh`
- Results are outputted to: `benchmark/_golden_benchmark-results/`

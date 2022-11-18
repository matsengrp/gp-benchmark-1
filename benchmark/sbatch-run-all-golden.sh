#!/bin/bash
#SBATCH -n 1                     #Number of processors in our pool
#SBATCH --mem 4G                 #Memory
#SBATCH -t 24:00:00              #Max wall time for entire job
#SBATCH -o batch_log.out         #output
#SBATCH -J GP-Benchmark          #Job name

source ~/.bashrc
conda activate bito
bash 0run-all-benchmark-golden.sh

#!/bin/bash
#SBATCH -n 1                     #Number of processors in our pool
#SBATCH --mem 12G                #Memory
#SBATCH -t 24:00:00              #Max wall time for entire job
#SBATCH -o makona_log.out        #output
#SBATCH -J GP-Makona             #Job name

source ~/.bashrc
conda activate bito
bash run-makona.sh

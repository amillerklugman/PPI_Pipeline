#!/bin/bash

# Submit the CPU-heavy job and capture its job ID
cpu_job_id=$(sbatch --parsable CPU_colabfold.sh)

# Submit the GPU-intensive job with a dependency on the CPU job
sbatch --dependency=afterok:$cpu_job_id GPU_colabfold.sh

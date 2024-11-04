#!/bin/bash
#SBATCH --job-name=run_colabfold   # Job name
#SBATCH --output=run_colabfold_%j.log # Standard output and error log (%j inserts the job ID)
#SBATCH --ntasks=1                       # Number of tasks (usually 1 for a single job)
#SBATCH --cpus-per-task=6               # Number of CPU cores per task
#SBATCH --mem=128G                       # Memory required
#SBATCH --time=8:00:00                   # Maximum run time
#SBATCH --partition=gpu                  # Sets partition to run on GPU
#SBATCH --gres=gpu:v100-sxm2:1           # Sets GPU type to A100
#SBATCH --mail-type=ALL                  # Get email notifications for job start, end, etc.
#SBATCH --mail-user= # email

# Load necessary modules (adjust based on your environment)
module load cuda/12.1
module load miniconda3 # Load Miniconda
module load gcc/9.2.0
module list

# Initialize Conda 
source <path/to/conda/install/sh>

# Activate ColabFold environment
conda activate colabfold

# 1. Run the SLURM script to process the dimers with ColabFold
echo "Running ColabFold on the generated dimers..."
bash <path/to/colabfold_structure.sh>
echo "ColabFold processing complete."

# 2. Move the relaxed PDB files to the PARP3_dimer_model_relax directory
echo "Moving relaxed PDB files to the PARP3_dimer_model_relax directory..."
python <path/to/move_relax_model.py>
echo "Relaxed PDB files moved."

# 3. Deactivate the Conda environment and change to PPIScreen
echo "Deactivating ColabFold environment..."
conda deactivate
echo "Switching to PPIScreen environment..."
conda activate ppiscreen
export PATH=<path/to/miniconda3/envs/ppiscreen/bin:$PATH>

# 4. Switch to the PPIScreenML directory
echo "Switching to PPIScreenML directory..."
cd <path/to/PPIscreenML>
echo "Switched to PPIScreenML directory."

# 5. Run the PPIScreenML tool
echo "Running PPIScreenML on the generated dimers..."
python <path/to/PPIscreenML/get_classification.py> \
    --working_directory <path/to/target_dimer_model_relax> \
    --protein1_chains_input A \
    --protein2_chains_input B \
    --csv_name interaction_all_proteins_vs_bait.csv 
echo "PPIScreenML processing complete."
echo "All jobs completed."

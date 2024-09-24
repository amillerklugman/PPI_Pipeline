#!/bin/bash
#SBATCH --job-name=run_dimer_colabfold   # Job name
#SBATCH --output=run_dimer_colabfold_%j.log # Standard output and error log (%j inserts the job ID)
#SBATCH --ntasks=1                       # Number of tasks (usually 1 for a single job)
#SBATCH --cpus-per-task=4                # Number of CPU cores per task
#SBATCH --mem=128G                       # Memory required
#SBATCH --time=8:00:00                   # Maximum run time
#SBATCH --partition=gpu                  # Sets partition to run on GPU
#SBATCH --gres=gpu:a100:1                # Request 1 GPU
#SBATCH --mail-type=ALL                  # Get email notifications for job start, end, etc.
#SBATCH --mail-user= # email

# Load necessary modules (adjust based on your environment)
module load cuda/12.1  # Load CUDA (if GPU version is used)
module load miniconda3 # Load Miniconda
module load gcc/9.2.0
module list

# Initialize Conda
source <path/to/miniconda3/etc/profile.d/conda.sh>

# Activate ColabFold environment
echo "Activating ColabFold environment..."
conda activate colabfold

# 1. Run the Python script to generate FASTA files from input csv
echo "Running Python script to generate FASTA files..."
python <path/to/get_fasta.py>
echo "FASTA generation complete."

# 2. Run the Python script to generate dimer FASTA files
echo "Running Python script to generate dimers..."
python </path/to/combine_fasta.py> >/dev/null 2>&1
echo "Dimer generation complete."

# 3. Run the SLURM script to process the dimers with ColabFold
echo "Running ColabFold on the generated dimers..."
bash </path/to/colabfold_iterate.sh>
echo "ColabFold processing complete."

# 4. Move the relaxed PDB files to the PARP3_dimer_model_relax directory
echo "Moving relaxed PDB files to the PARP3_dimer_model_relax directory..."
python <path/to/move_relax_model.py>
echo "Relaxed PDB files moved."

# 5. Deactivate the Conda environment and change to PPIScreen
echo "Deactivating ColabFold environment..."
conda deactivate
echo "Switching to PPIScreen environment..."
conda activate ppiscreen
export PATH=<path/to/miniconda3/envs/ppiscreen/bin>:$PATH

# 6. Switch to the PPIScreenML directory
echo "Switching to PPIScreenML directory..."
cd </path/to/PPIscreenML>
echo "Switched to PPIScreenML directory."

# 7. Run the PPIScreenML tool
echo "Running PPIScreenML on the generated dimers..."
python <path/to/get_classification.py> \
    --working_directory <path/to/working/dir> \
    --protein1_chains_input A \
    --protein2_chains_input B \
    --csv_name interaction_all_proteins_vs.csv >/dev/null
echo "PPIScreenML processing complete."
echo "All jobs completed."

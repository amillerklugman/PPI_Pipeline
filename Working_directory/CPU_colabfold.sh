#!/bin/bash
#SBATCH --job-name=run_MSA_colabfold   # Job name
#SBATCH --output=run_MSA_colabfold_%j.log # Standard output and error log (%j inserts the job ID)
#SBATCH --ntasks=1                       # Number of tasks (usually 1 for a single job)
#SBATCH --cpus-per-task=48                # Number of CPU cores per task
#SBATCH --mem=128G                       # Memory required
#SBATCH --time=8:00:00                   # Maximum run time
#SBATCH --partition=short                  # Sets partition to run on CPU
#SBATCH --mail-type=ALL                  # Get email notifications for job start, end, etc.
#SBATCH --mail-user= # email

# Load necessary modules (adjust based on your environment)
module load miniconda3 # Load Miniconda
module load gcc/9.2.0
module list

# Initialize Conda
source <path/to/conda/install>

# Activate ColabFold environment
echo "Activating ColabFold environment..."
conda activate colabfold

# 1. Run the Python script to generate FASTA files from input csv
echo "Running Python script to generate FASTA files..."
python <path/to/get_fasta.py>
echo "FASTA generation complete."

# 2. Run the Python script to generate dimer FASTA files
echo "Running Python script to generate dimers..."
python <path/to/combine_fasta.py> >/dev/null 2>&1
echo "Dimer generation complete."

# 3. Run the colabfold_search to generat M8 and a3m files
echo "Running colabfold_search..."
bash <path/to/colabfold_search.sh> 
echo "colabfold_search complete."

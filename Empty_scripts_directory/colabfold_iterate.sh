
# Initialize Conda 
source /work/daylab/andrew/millerklugman.a/miniconda3/etc/profile.d/conda.sh

# Activate ColabFold environment
conda activate colabfold

# Explicitly set the Conda environment Python to be used
export PATH=/work/daylab/andrew/millerklugman.a/miniconda3/envs/colabfold/bin:$PATH

# Add the correct directory where hhsearch is located to PATH
export PATH=/work/daylab/andrew/millerklugman.a/opt/hh-suite-3.2.0/build/src/:$PATH

# Define directories for dimer FASTA files and output
dimer_fasta_directory="/work/daylab/andrew/millerklugman.a/opt/localcolabfold/outputdir//PARP3_dimers"  # Dimer FASTA directory
colabfold_output_directory="/work/daylab/andrew/millerklugman.a/opt/localcolabfold/outputdir//PARP3_dimer_models"  # Output directory for ColabFold

# Iterate over each dimer FASTA file and run colabfold_batch
for dimer_fasta in "$dimer_fasta_directory"/*.fasta; do
    if [[ -f "$dimer_fasta" ]]; then
        echo "Running ColabFold on $dimer_fasta"
        
        # Run localcolabfold with appropriate arguments for each dimer FASTA
        /work/daylab/andrew/millerklugman.a/opt/localcolabfold/colabfold-conda/bin/colabfold_batch --templates --amber \
            --num-relax 2 --num-recycle 5 --use-gpu-relax "$dimer_fasta" "$colabfold_output_directory" \
            --max-msa 512:1024
        
        echo "Finished processing $dimer_fasta"
    else
        echo "No FASTA files found in $dimer_fasta_directory"
    fi
done

echo "All jobs completed."

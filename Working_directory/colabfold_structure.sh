# Initialize Conda 
source <path/to/miniconda3/etc/profile.d/conda.sh>

# Activate ColabFold environment
conda activate colabfold

# Explicitly set the Conda environment Python to be used
export PATH=<path/to/miniconda3/envs/colabfold/bin:$PATH>

# Add the correct directory where hhsearch is located to PATH
export PATH=<path/to/opt/hh-suite-3.2.0/build/src/:$PATH>

# Define directories for A3M and PDB files and output
target_mmseq_directory="<path/to/target_MMSEQ>"  # Directory with A3M and PDB files
output_dir="<path/to/target_dimer_models>"
LOCALPDBPATH="<path/to/localcolabfold/database/pdb/divided>"
random_seed=0  # Random seed

# Iterate over each A3M file and find the corresponding PDB file
for a3m_file in "$target_mmseq_directory"/*.a3m; do
    if [[ -f "$a3m_file" ]]; then
        # Extract base filename to find the corresponding PDB file
        base_name=$(basename "$a3m_file" .a3m)
        pdb_hit_file="$target_mmseq_directory/${base_name}_pdb100_230517.m8"

        # Check if any relaxed PDB file already exists in the output directory
        relaxed_pdb_files=($(find "$output_dir" -type f -name "${base_name}*_relaxed_*.pdb"))

        if [[ ${#relaxed_pdb_files[@]} -gt 0 ]]; then
            echo "Relaxed PDB files already exist for $a3m_file. Skipping ColabFold run."
            continue
        fi

        if [[ -f "$pdb_hit_file" ]]; then
            echo "Running ColabFold on $a3m_file with PDB hits from $pdb_hit_file"
            
            # Run localcolabfold with appropriate arguments for each A3M and matching PDB file
            <path/to/localcolabfold/colabfold-conda/bin/colabfold_batch> \
                --amber \
                --num-recycle 8 \
                --num-relax 2 \
                --use-gpu-relax \
                --pdb-hit-file "$pdb_hit_file" \
                --local-pdb-path "$LOCALPDBPATH" \
                --random-seed "$random_seed" \
                "$a3m_file" \
                "$output_dir"
            
            echo "Finished processing $a3m_file"
        else
            echo "PDB hit file not found for $a3m_file: $pdb_hit_file"
        fi
    else
        echo "No A3M files found in $target_mmseq_directory"
    fi
done

echo "All jobs completed."

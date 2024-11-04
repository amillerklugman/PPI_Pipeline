import os
import tempfile

# Define your directories and parameters
fasta_directory = "<path/to/target_interactors>"  # Change to your FASTA files directory
parp3_fasta_path = "<path/to/target.fasta>"  # Path to your target protein FASTA file
output_directory = "<path/to/target_dimers>"  # Directory to save dimer FASTA files

# Create the output directory if it doesn't exist
if not os.path.exists(output_directory):
    os.makedirs(output_directory)

# Function to extract the ID from a FASTA header
def extract_protein_id(fasta_header):
    return fasta_header.split('|')[1]  # Extract the ID (e.g., Q9Y6F1 from '>sp|Q9Y6F1|...')

# Function to create a dimer FASTA
def create_dimer_fasta(protein_fasta_path, parp3_fasta_path, output_directory):
    with open(protein_fasta_path, 'r') as protein_file, open(parp3_fasta_path, 'r') as parp3_file:
        protein_fasta_lines = protein_file.readlines()
        parp3_fasta_lines = parp3_file.readlines()

        # Extract IDs from the FASTA headers
        protein_id = extract_protein_id(protein_fasta_lines[0].strip())
        parp3_id = extract_protein_id(parp3_fasta_lines[0].strip())

        # Get the sequences (ignoring the first line, which is the header)
        protein_sequence = ''.join(protein_fasta_lines[1:]).replace('\n', '')
        parp3_sequence = ''.join(parp3_fasta_lines[1:]).replace('\n', '')

        # Create the new header for the dimer
        combined_header = f">{protein_id}_{parp3_id}_dimer"

        # Create a new dimer FASTA file
        dimer_filename = f"{protein_id}_{parp3_id}_dimer.fasta"
        dimer_fasta_path = os.path.join(output_directory, dimer_filename)

        with open(dimer_fasta_path, 'w') as dimer_fasta:
            dimer_fasta.write(f"{combined_header}\n")
            dimer_fasta.write(f"{protein_sequence}:{parp3_sequence}\n")  # Combine with colon (:)

        return dimer_fasta_path

# Iterate through each FASTA file in the directory
for fasta_file in os.listdir(fasta_directory):
    if fasta_file.endswith(".fasta"):
        fasta_path = os.path.join(fasta_directory, fasta_file)

        # Create a dimer FASTA with the current protein and PARP3
        dimer_fasta = create_dimer_fasta(fasta_path, parp3_fasta_path, output_directory)
        print(f"Dimer created: {dimer_fasta}")

print("All dimers created.")

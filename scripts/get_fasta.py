import requests
import csv
import os

# Function to fetch and save the first isoform FASTA file for a given protein name
def get_fasta(protein_name, output_directory):
    url = f"https://rest.uniprot.org/uniprotkb/search?query={protein_name}+AND+organism_id:9606&format=fasta"
    response = requests.get(url)
    
    if response.status_code == 200 and response.text.startswith(">"):
        # Split the FASTA file by entries (each entry starts with '>')
        fasta_entries = response.text.strip().split('>')

        # Take only the first entry (primary isoform) and add back the '>'
        primary_isoform_fasta = f">{fasta_entries[1]}" if len(fasta_entries) > 1 else f">{fasta_entries[0]}"

        # Create output file path
        fasta_file_path = os.path.join(output_directory, f"{protein_name}.fasta")

        # Save the primary isoform FASTA file
        with open(fasta_file_path, "w") as fasta_file:
            fasta_file.write(primary_isoform_fasta)
        print(f"FASTA file for {protein_name} saved as {fasta_file_path}")
    else:
        print(f"Error: Unable to fetch FASTA for {protein_name}")

# Function to read protein names from a CSV and fetch their primary isoform FASTA files
def fetch_fasta_from_csv(csv_file_path, output_directory):
    # Ensure output directory exists
    os.makedirs(output_directory, exist_ok=True)

    with open(csv_file_path, newline='') as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            protein_name = row[0].strip()  # Assuming the first column contains the protein name
            get_fasta(protein_name, output_directory)
# define directories 
csv_file_path = ""  # Path to the CSV file containing protein names
output_directory = ""  # Output directory to save the FASTA files

fetch_fasta_from_csv(csv_file_path, output_directory)

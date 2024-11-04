import os
import shutil

# Define source and destination directories
source_dir = '<path/to/target_dimer_models>'
destination_dir = '<path/to/target_dimer_model_relax>'

# Create destination directory if it doesn't exist
os.makedirs(destination_dir, exist_ok=True)

# Loop through all files in the source directory
for filename in os.listdir(source_dir):
    # Check if the file is a PDB file and contains '_rank_001_' or '_rank_002_' and '_relaxed_'
    if filename.endswith('.pdb') and ('_rank_001_' in filename or '_rank_002_' in filename) and '_relaxed_' in filename:
        # Construct full file path for the PDB file
        source_file = os.path.join(source_dir, filename)
        destination_file = os.path.join(destination_dir, filename)
        # Copy the PDB file to the destination directory
        shutil.copy2(source_file, destination_file)
        
        # Construct the associated JSON file name
        json_filename = filename.replace('.pdb', '.json')
        source_json_file = os.path.join(source_dir, json_filename)
        destination_json_file = os.path.join(destination_dir, json_filename)
        
        # Check if the JSON file exists and copy it
        if os.path.exists(source_json_file):
            shutil.copy2(source_json_file, destination_json_file)
    
    # Check if the file is a JSON file and contains '_rank_001_' or '_rank_002_'
    elif filename.endswith('.json') and ('_rank_001_' in filename or '_rank_002_' in filename):
        # Construct full file path for the JSON file
        source_file = os.path.join(source_dir, filename)
        destination_file = os.path.join(destination_dir, filename)
        # Copy the JSON file to the destination directory
        shutil.copy2(source_file, destination_file)

print("Files copied successfully.")

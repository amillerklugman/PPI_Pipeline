# PPI_Pipeline
Pipeline for high-throughput analysis of protein-protein interactions, using localcolabfold and PPIScreenML

This repository serves as a storage for the script and files needed to perform a high-throughput screen of protein-protein interactions. PPIScreenML is a tool for structure-based prediction that can be downloaded at https://github.com/victoria-mischley/PPIScreenML The tool uses a gradient boosting library to predict interactions between proteins modeled with collab fold. All file paths have been deleted to allow for changes based on the intended use

Conda environments have been added and can be downloaded once the path in the yml file is changed. Colabfold and PPIscreen each have their own environment to avoid conflict between program versions.

## Usage 
### Installation 
The conda environments in the [requirements](https://github.com/amillerklugman/PPI_Pipeline/tree/main/requirements) can be cloned into the WSL environment and installed
```
# Download the yml files for the coda environments into your machine
wget https://github.com/amillerklugman/PPI_Pipeline/blob/e030d08c648792e484c24bbf8038f8e1ffe79604/requirements/colabfold_requirements.yml \
     https://github.com/amillerklugman/PPI_Pipeline/blob/e030d08c648792e484c24bbf8038f8e1ffe79604/requirements/ppiscreen_requirements.yml

# Create a conda environment for each program
conda env create -f colabfold_requirements.yml.
conda env create -f ppiscreen_requirements.yml
```

PPIScreenML can be downloaded from https://github.com/victoria-mischley/PPIScreenML (Mischley et al 2024). You will need to install PyRosetta https://www.pyrosetta.org/downloads with the instructions listed on the PPIScreenML directory. Installation of hh-suite is also required https://github.com/soedinglab/hh-suite 
```
conda install -c conda-forge -c bioconda hhsuite
```

Localcolabfold is an implementation of colabfold meant to run on a local machine for high-throughput analysis. Localcolabfold was developed by [YoshitakaMo](https://github.com/YoshitakaMo/localcolabfold) as a extension of the work of [Mirdita M, Schütze K, Moriwaki Y, Heo L, Ovchinnikov S and Steinegger M.](https://github.com/sokrypton/ColabFold) A detailed explanation of installing localcolabfold can be found on the programs GitHub repository. If you are planning on high-throughput analysis make sure to follow the steps pertaining to colabfold_Search with instrucutions to download the reference databases at https://colabfold.mmseqs.com/  

### Input Files
The scripts use a csv file as input to create individual fasta files for each screened protein. The input csv should be formatted as follows with the first column containing the names of the screening proteins. The csv file should only contain the protein names as the IDs and Fasta are found using get_fasta.py
![image](https://github.com/user-attachments/assets/057aae59-156f-4b24-8783-80534ff4377b)

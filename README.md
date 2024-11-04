# PPI_Pipeline
Pipeline for high-throughput analysis of protein-protein interactions, using localcolabfold and PPIScreenML

This repository serves as a storage for the script and files needed to perform a high-throughput screen of protein-protein interactions. PPIScreenML is a tool for structure-based prediction that can be downloaded at https://github.com/victoria-mischley/PPIScreenML The tool uses a gradient boosting library to predict interactions between proteins modeled with collab fold. All file paths have been deleted to allow for changes based on the intended use

Conda environments have been added and can be downloaded once the path in the yml file is changed. Colabfold and PPIscreen each have their own environment to avoid conflict between program versions.

## Usage 
### Input Files
The scripts use a csv file as input to create individual fasta files for each screened protein. The input csv should be formatted as follows with the first column containing the names of the screening proteins. The csv file should only contain the protein names as the IDs and Fasta are found using get_fasta.py
![image](https://github.com/user-attachments/assets/057aae59-156f-4b24-8783-80534ff4377b)

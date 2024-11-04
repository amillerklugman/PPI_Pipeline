DATABASE_PATH="<path/to/localcolabfold/database>"
INPUT_DIR="<path/to/target_dimers>"
OUTPUT_DIR="<path/to/target_MMSEQ>"

<path/to/localcolabfold/colabfold-conda/bin/colabfold_search> \
    --use-env 1 \
    --use-templates 1 \
    --db-load-mode 2 \
    --db2 pdb100_230517 \
    --threads 42 \
    ${INPUT_DIR} \
    ${DATABASE_PATH} \
    ${OUTPUT_DIR}

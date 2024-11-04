DATABASE_PATH="/work/daylab/andrew/millerklugman.a/opt/localcolabfold/database"
INPUT_DIR="/work/daylab/andrew/millerklugman.a/opt/localcolabfold/outputdir//PARP3_dimers"
OUTPUT_DIR="/work/daylab/andrew/millerklugman.a/opt/localcolabfold/outputdir//PARP3_MMSEQ"

/work/daylab/andrew/millerklugman.a/opt/localcolabfold/colabfold-conda/bin/colabfold_search \
    --use-env 1 \
    --use-templates 1 \
    --db-load-mode 2 \
    --db2 pdb100_230517 \
    --threads 42 \
    ${INPUT_DIR} \
    ${DATABASE_PATH} \
    ${OUTPUT_DIR}
# Get dag
snakemake --dag | dot -Tpng > dag.png
# Run
snakemake --core 16 --resources download_slots=4

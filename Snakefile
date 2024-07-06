configfile: "config/config.yaml"

srrlist = set([line.strip().split()[0] for line in open(config["inputfile"]["groupfile"], 'r')])
samples = set([line.strip().split()[1] for line in open(config["inputfile"]["groupfile"], 'r')])

include: "rules/common.smk"

rule all:
    input:
        expand("rawfastq/{srr}/{srr}.sra", srr=srrlist) + 
        expand("results/{sample}/quant.sf", sample=samples)

# download and extract SRA files
include: "rules/01_prefetch.smk"

# Trim fastq
include: "rules/02_trimgalore.smk"

# Salmon quant
include: "rules/03_salmon.smk"

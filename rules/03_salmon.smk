rule salmon:
    input:
        trimmed_fastq = lambda wildcards: get_fastq_list(config["mode"], config["inputfile"]["groupfile"], wildcards.sample)
    output:
        count_file = "results/{sample}/quant.sf"
    params:
        index = config["salmon"]["salmon_index"],
        samplename = "{sample}",
        option = config["salmon"]["param"],
        fastqpath = lambda wildcards: get_fastq_path(config["mode"], config["inputfile"]["groupfile"], wildcards.sample)
    log:
        "logs/{sample}_salmon.log"
    threads: config["salmon"]["threads"]
    shell:
        """
        if [ "{config[mode]}" == "single" ]; then
            salmon quant -i {params.index} -l A -r <(zcat {params.fastqpath}) -p {threads} {params.option} -o results/{params.samplename} > {log} 2>&1
        else
            salmon quant -i {params.index} -l A -1 <(zcat {params.fastqpath[0]}) -2 <(zcat {params.fastqpath[1]}) -p {threads} {params.option} -o results/{params.samplename} > {log} 2>&1
        fi
        """

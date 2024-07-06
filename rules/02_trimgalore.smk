rule trim_galore:
    input:
        fastq_files = "rawfastq/{srr}.fastq.gz" if config["mode"] == "single" else ["rawfastq/{srr}_1.fastq.gz", "rawfastq/{srr}_2.fastq.gz"]
    output:
        trimmed_fastq = "trimgalore_result/{srr}_trimmed.fq.gz" if config["mode"] == "single" else ["trimgalore_result/{srr}_1_val_1.fq.gz", "trimgalore_result/{srr}_2_val_2.fq.gz"]
    params:
        option = config["trim"]["param"]
    log:
        "logs/{srr}_trimgalore.log"
    threads: config["trim"]["threads"]
    shell:
        """
        if [ "{config[mode]}" == "single" ]; then
            trim_galore {params.option} --cores {threads} {input.fastq_files} -o trimgalore_result/ > {log} 2>&1
        else
            trim_galore --paired {params.option} --cores {threads} {input.fastq_files[0]} {input.fastq_files[1]} -o trimgalore_result/ > {log} 2>&1
        fi
        """

rule trim_galore_se:
    input:
        rules.extract_se.output
    output:
        trimmed_fastq = "trimgalore_result/{srr}_trimmed.fq.gz"
    params:
        option = config["trim"]["param"]
    log:
        "logs/{srr}_trimgalore.log"
    threads: config["trim"]["threads"]
    shell:
        """
        trim_galore {params.option} \
            --cores {threads} {input} -o trimgalore_result/ > {log} 2>&1
        """


rule trim_galore_pe:
    input:
        rules.extract_pe.output
    output:
        trimmed_fastq = ["trimgalore_result/{srr}_1_val_1.fq.gz", "trimgalore_result/{srr}_2_val_2.fq.gz"]
    params:
        option = config["trim"]["param"]
    log:
        "logs/{srr}_trimgalore.log"
    threads: config["trim"]["threads"]
    shell:
        """
        trim_galore --paired {params.option} \
            --cores {threads} {input[0]} {input[1]} -o trimgalore_result/ > {log} 2>&1
        """


rule bowtie2_se:
    input:
        rules.trim_galore_se.output
    output:
        bam_file = "bowtie2_alignment/{srr}_se.bam"
    params:
        index = config["align"]["index"],
        option = config["align"]["param"]
    log:
        "logs/{srr}_bowtie2.log"
    threads: config["align"]["threads"]
    shell:
        """
        bowtie2 {params.option} -p {threads} -x {params.index} -U {input} 2>> {log} | \
        samtools sort -m 8G -@ {threads} -O BAM -o {output.bam_file} -

        samtools index -@ {threads} {output.bam_file}
        """


rule bowtie2_pe:
    input:
        rules.trim_galore_pe.output
    output:
        bam_file = "bowtie2_alignment/{srr}_pe.bam"
    params:
        index = config["align"]["index"],
        option = config["align"]["param"]
    log:
        "logs/{srr}_bowtie2.log"
    threads: config["align"]["threads"]
    shell:
        """
        bowtie2 {params.option} -p {threads} -x {params.index} -1 {input[0]} -2 {input[1]} 2>> {log} | \
        samtools sort -m 8G -@ {threads} -O BAM -o {output.bam_file} -

        samtools index -@ {threads} {output.bam_file}
        """


rule process_bam:
    input:
        bam_file = "bowtie2_alignment/{srr}_{type}.bam"
    output:
        marked_bam = "bowtie2_alignment/{srr}_{type}.marked.bam",
        final_bam = "bowtie2_alignment/{srr}_{type}.filter.bam"
    log:
        "logs/{srr}_{type}_bamfilter.log"
    threads: config["filter"]["threads"]
    params:
        filter = config["filter"]["param"]
    shell:
        """
        # Mark duplicate
        sambamba markdup -t {threads} {input.bam_file} {output.marked_bam} 2>> {log}
        # Filter BAM file
        sambamba view -h -t {threads} -f bam -F "{params.filter}" {output.marked_bam} > {output.final_bam} 2>> {log}
        """


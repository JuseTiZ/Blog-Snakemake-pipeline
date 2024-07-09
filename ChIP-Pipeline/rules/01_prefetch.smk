rule download:
    output:
        srafile = "rawfastq/{srr}/{srr}.sra"
    log:
        "logs/{srr}_download_prefetch.log"
    params:
        srrid = "{srr}"
    threads: 1
    retries: config["download"]["retry"]
    resources:
        download_slots = 1 
    shell:
        """
        if [ -e {output.srafile}.lock ]; then
            rm {output.srafile}.lock
            echo "{output.srafile} lock found but no output file! Deleting..." >> {log}
        fi

        prefetch --max-size 100000000 --progress --output-directory rawfastq {params.srrid} > {log} 2>&1
        if [ -e {output.srafile} ]; then
            echo "{output.srafile} download finished!" >> {log}
        else
            mv {output.srafile}* {output.srafile}
            echo "{output.srafile} not find! May end with .sralite. Renaming..." >> {log}
        fi
        """

rule extract_se:
    input:
        rules.download.output
    output:
        fastq_files = "rawfastq/{srr}.fastq.gz"
    log:
        "logs/{srr}_extract.log"
    params:
        srrid = "{srr}"
    threads: config["download"]["extract_threads"]
    wildcard_constraints:
        srr = "^[^_]+$"
    shell:
        """
        fasterq-dump {input} --progress --details --split-files -v --outdir rawfastq --threads {threads} > {log} 2>&1
        pigz -p {threads} rawfastq/{params.srrid}*.fastq

        if [ -e rawfastq/{params.srrid}_1.fastq.gz ]; then
            mv rawfastq/{params.srrid}_1.fastq.gz {output.fastq_files}
            echo "Single extract finished! (Renamed _1.fastq.gz)" >> {log}
        else
            echo "Single extract finished!" >> {log}
        fi
        """

rule extract_pe:
    input:
        rules.download.output
    output:
        fastq_files = ["rawfastq/{srr}_1.fastq.gz", "rawfastq/{srr}_2.fastq.gz"]
    log:
        "logs/{srr}_extract.log"
    params:
        srrid = "{srr}"
    threads: config["download"]["extract_threads"]
    shell:
        """
        fasterq-dump {input} --progress --details --split-files -v --outdir rawfastq --threads {threads} > {log} 2>&1
        pigz -p {threads} rawfastq/{params.srrid}*.fastq

        if [ -e rawfastq/{params.srrid}_1.fastq.gz ] && [ -e rawfastq/{params.srrid}_2.fastq.gz ]; then
            echo "Paired extract finished!" >> {log}
        else
            echo "Paired extract failed: one or both FASTQ files missing!" >> {log}
            exit 1
        fi
        """
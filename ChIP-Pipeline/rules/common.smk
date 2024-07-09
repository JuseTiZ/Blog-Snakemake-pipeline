def getTreatBam(sample, samples):
    '''
    Get treat bam for macs3 rule.
    '''
    srrlist = samples[sample]['chip'].split('|')
    type = 'se' if samples[sample]['type'] == 'single' else 'pe'
    inputfiles = [f"bowtie2_alignment/{srr}_{type}.filter.bam" for srr in srrlist]
    return ' '.join(inputfiles)

def getInputBam(sample, samples):
    '''
    Get treat bam for macs3 rule.
    '''
    srrlist = samples[sample]['input'].split('|')
    type = 'se' if samples[sample]['type'] == 'single' else 'pe'
    inputfiles = [f"bowtie2_alignment/{srr}_{type}.filter.bam" for srr in srrlist]
    return ' '.join(inputfiles)

def getBamType(sample, samples):
    '''
    Get bam type to specify in macs3 call peak.
    '''
    type = 'BAM' if samples[sample]['type'] == 'single' else 'BAMPE'
    return type

def getInputMACS3(sample, samples):
    '''
    Get input file for macs3 rule.
    '''
    srrids = []
    type = 'se' if samples[sample]['type'] == 'single' else 'pe'
    for srrtype in ['chip', 'input']:
        srrlist = samples[sample][srrtype].split('|')
        srrids += srrlist
    
    inputfiles = [f"bowtie2_alignment/{srr}_{type}.filter.bam" for srr in srrids]
    return inputfiles

def getAllInput(samples):
    '''
    Get all Input file for Snakemake.
    '''
    fastqfile = []
    bamfile = []
    peakfile = []

    for sample, info in samples.items():
        peakfile.append(f'results/{sample}/{sample}_peaks.narrowPeak')
        srrids = []

        for srrtype in ['chip', 'input']:
            srrlist = info[srrtype].split('|')
            srrids += srrlist
        
        for srrid in srrids:
            if info['type'] == 'single':
                fastqfile.append(f'rawfastq/{srrid}.fastq.gz')
                bamfile.append(f'bowtie2_alignment/{srrid}_se.bam')
            elif info['type'] == 'paired':
                fastqfile.append(f'rawfastq/{srrid}_1.fastq.gz')
                fastqfile.append(f'rawfastq/{srrid}_2.fastq.gz')
                bamfile.append(f'bowtie2_alignment/{srrid}_pe.bam')
    
    inputfile = fastqfile + bamfile + peakfile
    return inputfile
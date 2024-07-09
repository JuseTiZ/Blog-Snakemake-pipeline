import csv

def get_fastq_list(mode, filepath, group):
    '''
    Get fastq list for each group.
    '''
    group_fastq = {}
    with open(filepath, 'r') as f:
        for line in f:
            info = line.strip().split()
            if info[1] not in group_fastq:
                group_fastq[info[1]] = [info[0]]
            else:
                group_fastq[info[1]].append(info[0])
    
    if mode == "single":
        fastq_path_list = [f'trimgalore_result/{i}_trimmed.fq.gz' for i in group_fastq[group]]
        return fastq_path_list
    elif mode == "paired":
        fastq_path_list1 = [f'trimgalore_result/{i}_1_val_1.fq.gz' for i in group_fastq[group]]
        fastq_path_list2 = [f'trimgalore_result/{i}_2_val_2.fq.gz' for i in group_fastq[group]]
        fastq_path_list = fastq_path_list1 + fastq_path_list2
        return fastq_path_list


def get_fastq_path(mode, filepath, group):
    '''
    Get fastq path for each group.
    '''
    group_fastq = {}
    with open(filepath, 'r') as f:
        for line in f:
            info = line.strip().split()
            if info[1] not in group_fastq:
                group_fastq[info[1]] = [info[0]]
            else:
                group_fastq[info[1]].append(info[0])
    
    if mode == "single":
        fastq_path_list = [f'trimgalore_result/{i}_trimmed.fq.gz' for i in group_fastq[group]]
        return ' '.join(fastq_path_list)
    elif mode == "paired":
        fastq_path_list1 = [f'trimgalore_result/{i}_1_val_1.fq.gz' for i in group_fastq[group]]
        fastq_path_list2 = [f'trimgalore_result/{i}_2_val_2.fq.gz' for i in group_fastq[group]]
        return [' '.join(fastq_path_list1), ' '.join(fastq_path_list2)]
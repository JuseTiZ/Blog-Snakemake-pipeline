mkdir hg38_salmon_index
wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_44/gencode.v44.pc_transcripts.fa.gz
wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_44/GRCh38.primary_assembly.genome.fa.gz
grep "^>" <(gunzip -c GRCh38.primary_assembly.genome.fa.gz) | cut -d " " -f 1 > decoys.txt
sed -i.bak -e 's/>//g' decoys.txt
cat gencode.v44.pc_transcripts.fa.gz GRCh38.primary_assembly.genome.fa.gz > GRCh38.gentrome.fa.gz
salmon index -t GRCh38.gentrome.fa.gz -d decoys.txt -p 12 -i hg38_salmon_index --gencode > hg38_salmon_index/salmon_index.log 2>&1
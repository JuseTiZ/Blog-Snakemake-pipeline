## Blog-Snakemake-Pipeline

该 repository 储存所有在博客中出现过的 Pipeline。

### ChIP-Pipeline

该 Pipeline 用于进行 ChIP-seq 数据的 call peak。流程如下：

1. `prefetch` 下载数据并提取压缩
2. `trim_galore` - `Bowtie2` - `Sambamba`
3. `MACS3` 进行 call peak

### Tutorial-Pipeline

该 Pipeline 用于进行 RNA-seq 数据的表达定量。流程如下：

1. `prefetch` 下载数据并提取压缩
2. `trim_galore` - `salmon`

主要做 Snakemake Pipeline 的构建教程示例用。

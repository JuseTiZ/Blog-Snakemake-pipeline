## ChIP-Pipeline

该 Pipeline 对应以下博客文章：

[通过 bowtie2 + macs3 分析 ChIP-Seq 数据](https://biojuse.com/2024/04/16/%E9%80%9A%E8%BF%87%20bowtie2%20+%20macs3%20%E5%88%86%E6%9E%90%20ChIP-Seq%20%E6%95%B0%E6%8D%AE/)

下载 Pipeline

```shell
git clone https://github.com/JuseTiZ/Blog-Snakemake-pipeline.git
cd Blog-Snakemake-pipeline/ChIP-Pipeline
```

安装环境

```shell
mamba env create --file envs/environment.yaml
mamba activate ChIP-pipeline
```

此后，请对 `config/config.yaml` 及 `config/sample.yaml` 进行修改，然后运行 Pipeline

```shell
snakemake --core 20 --resources download_slots=4
```


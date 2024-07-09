## Tutorial-Pipeline

该 Pipeline 对应以下博客文章：

[Snakemake pipeline 搭建的进阶教程](https://biojuse.com/2024/07/06/Snakemake%20pipeline%20%E6%90%AD%E5%BB%BA%E7%9A%84%E8%BF%9B%E9%98%B6%E6%95%99%E7%A8%8B/)

复现该 Pipeline 的步骤如下：

下载 Pipeline

```shell
git clone https://github.com/JuseTiZ/Blog-Snakemake-pipeline.git
cd Blog-Snakemake-pipeline/Tutorial-Pipeline
```

安装环境

```shell
mamba env create --file envs/environment.yaml
mamba activate ST-pipeline
```

构建 hg38 salmon 索引

```shell
bash hg38_salmon_index.sh
```

运行该 Pipeline

```shell
snakemake --core 16 --resources download_slots=4
```


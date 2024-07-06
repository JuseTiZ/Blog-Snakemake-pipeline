## ST-pipeline repository

该 repository 对应该[博客文章](https://biojuse.com/2024/07/06/Snakemake%20pipeline%20搭建的进阶教程/)。

复现该 Pipeline 的步骤如下：

下载 Pipeline

```shell
git clone git@github.com:JuseTiZ/ST-pipeline.git
cd ST-pipeline
```

安装环境

```shell
mamba env create --file envs/environment.yaml
```

构建 hg38 salmon 索引

```shell
bash hg38_salmon_index.sh
```

运行该 Pipeline

```shell
snakemake --core 16 --resources download_slots=4
```


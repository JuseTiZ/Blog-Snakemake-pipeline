## ChIP-Pipeline

`config.yaml` 中需要自主准备的参数：

- bowtie2 使用的索引（align index）。
- 染色体大小文件（macs chromsize）。

`sample.yaml` 中需要自主准备的参数：

- 不同样本下的处理组 SRR id（chip）。
- 不同样本下的对照组 SRR id（input）。
- 以上数据的类型（`single` or `paired`）。

样本名请自主指定（例如 `hg38_Prdm9A-A-ChIP_rep1`），样本名将决定最后输出的文件前缀。

# RNA-Seq

Tutorial for running nf-core/rnaseq pipeline on the biocluster.

## Requirements

### 1. project directory

Create a directory to make your analysis. The name nf-core is used here as an example.
In this folder, create two additional directories named `config` and `scripts`.  Copy **nf-params.json** in `config`, **launch_nextflow.sh** in `scripts`, **local.conf** and **samplesheet.csv** in `nf-core`.   

A raw directory with symbolic links to the raw data files can also be created and used in the samplesheet.csv file.

`nf-core`  
├── `config`  
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└── nf-params.json   
├── `scripts`    
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└── launch_nextflow.sh          
└── `raw` (contains **symbolic links** to fasta files)  
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── sample1_R1.fastq.gz  
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── sample1_R2.fastq.gz  
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── sample2_R1.fastq.gz  
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└── sample2_R2.fastq.gz  
├── local.conf   
└── samplesheet.csv
     
### 2. `nextflow` installation

To install nextflow, run this command in your project folder: `curl -s https://get.nextflow.io | bash`.  
This will create a nextflow binary in your folder.  

### 3. samplesheet.csv

A CSV file with a table of the sample names and file paths of the sequences. Please refer to [nf-core/rnaseq documentation](https://nf-co.re/rnaseq/usage) for more details.

| sample | fastq_1    | fastq_2    | strandedness  
| ------------ | -------- | ------------- | ---------- | 
| sample1  | `/full/path/to/`sample1_R1.fastq.gz | `/full/path/to/`sample1_R2.fastq.gz | unstranded | 
| sample2  | `/full/path/to/`sample2_R1.fastq.gz | `/full/path/to/`sample2_R2.fastq.gz | unstranded | 

Strandedness can either be `forward`, `reverse` or `unstranded`.
Also refer to [salmon documentation](https://salmon.readthedocs.io/en/latest/library_type.html) to set `salmon_quant_libtype` in **nf-params.json** according to your library.

### 4. reference genome (fasta and gtf files)
A fasta and a gtf file of the reference genome. For bosTaurus9, follow this [link](https://www.ncbi.nlm.nih.gov/assembly/GCF_002263795.1) and get these files:      
- GCF_002263795.1_ARS-UCD1.2_genomic.fa  
- GCF_002263795.1_ARS-UCD1.2_genomic.gtf  

## Running the pipeline as a batch job

The script **launch_nextflow.sh** is used to run nextflow on the biocluster with: `qsub scripts/launch_nextflow.sh` from your project folder.

```
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -pe smp 2

./nextflow run nf-core/rnaseq -r 3.3 -resume -params-file config/nf-params.json -profile conda -c local.conf
```  

## Additionnal notes

### GTF issues

- The module `rsem-extract-reference-transcripts` will complain and stop the pipeline if the gtf file contains empty gene identification like `gene_id ""`. The script **modify_gtf.R** can be used to remove those entries. For bosTaurus9, only scaffold NC_006853.1 is concerned. 21 lines must be removed.

- Entries in gtf files downloaded from NCBI do not always have a `gene_biotype` field in the 9th column. Using `"skip_biotype_qc": true` in the **nf-params.json** will prevent workflow interruptions from featureCount. 
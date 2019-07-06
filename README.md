# Dropseq
#### Pipeline for processing Drop-seq data from FASTQ to per cell barcode gene expression

This pipeline is meant to provide an easy interface and automation for running Drop-seq tools, Picard, and some new scripts developed here. 
Drop-seq tools is developed by James Nemesh and the McCarroll lab at the Harvard Medical School (http://mccarrolllab.com/dropseq). 
The procedure is outlined here: http://mccarrolllab.com/wp-content/uploads/2016/03/Drop-seqAlignmentCookbookv1.2Jan2016.pdf

Usage
-----

| File | Description |
|------|-------------|
| dropseq | main program |
| config.txt | global parameters and file paths |
| get_bam_trans_reads_counts.pl | extracts gene and read counts from aligned BAM |
| plot_trans_reads_counts.r | generate plots of cumulative gene/read distributions |

```
Drop-seq pipeline v0.1 - Creaded by John P. McCrow (4/12/2018)

Usage: dropseq [command] (options)

  Commands:
    fastq2bam     convert paired FASTQ to sorted BAM
    tagXC         add cell barcodes to BAM, XC tag
    tagXM         add molecular barcodes to BAM, XM tag
    filter        filter out low quality barcode reads by XQ tag
    trimAdapter   trim partial SMART adapter from 5'-end
    trimPolyA     trim partial poly-A from 3'-end
    bam2fastq     convert trimmed/filtered BAM to FASTQ for use in alignment
    
    starAlign     alignment to reference using STAR
    sortSam       sort aligned SAM and convert to BAM
    
    merge         merge unaligned and aligned BAM files
    tagGenes      tag exons/genes in BAM, GE tag
    correctXC     correct bead synthesis errors
    
    histogram     plot cumulative read and gene distributions
    dge           digital gene expression per cell barcode
    cleanup       remove some intermediate files
    
    make          create make file to automate entire pipeline
 
  Options:
    --help, -h          show this help page
    --list, -l    file  file with list of sample names
                        runs sample number set in SGE_TASK_ID
    --sample, -s  name  library/sample name (base filename)
                        one of -l or -s is required
    --rm                remove output file from previous step when finished

    * See command help for command specific options
```

Installation
------------

1. Make sure all dependencies are installed (see below).
2. Edit the config.txt file to set file paths. It is also possible to add a separate copy 
of config.txt to your current directory when running dropseq which will override the global config.txt.
3. Test dropseq to see if all dependancies are found
```
dropseq test
```

Dependencies
------------

* Perl (https://www.perl.org/get.html)
* Java 1.8+ (http://www.oracle.com/technetwork/java/javase/downloads/index.html)
* Drop-seq Tools (http://mccarrolllab.com/download/1276)
* Picard 2+ (http://broadinstitute.github.io/picard)
* STAR Aligner (https://github.com/alexdobin/STAR/releases)

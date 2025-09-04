#!/bin/bash

# Part 1
# How many features? First output of:
wc -l ce11_genes.bed 

# How many features per chromosome? 
cut -f 1 ce11_genes.bed | uniq -c

# How many features per strand?
cut -f 6 ce11_genes.bed > strands.txt
sort strands.txt | uniq -c


# Part 3
# Which SMTSDs have the most samples? Run:
cut -f 7 GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | sort | uniq -c | sort| tail -n 1
# Whole Blood, with 3288 samples!

# Which samples have "RNA"? First output of:
grep RNA GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | wc

# Which samples lack "RNA" First output of:
grep -v RNA GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | wc


# Part 5
# How many entries are there for each feature type? Run the following command:
gzip -dc gencode.v46.basic.annotation.gtf.gz | grep -v "##" | cut -f 3 | sort | uniq -c | sort

# How many lncRNA entries are on each chromosome?
gzip -dc gencode.v46.basic.annotation.gtf.gz|grep "lncRNA"|cut -f 1|sort|uniq -c | sort
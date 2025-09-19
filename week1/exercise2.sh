#!/bin/bash

wget https://hgdownload.soe.ucsc.edu/goldenPath/hg19/bigZips/hg19.chrom.sizes

grep -v _ hg16.chrom.sizes > hg16-main.chrom.sizes

bedtools makewindows -g hg16-main.chrom.sizes -w 1000000 > hg16-1mb.bed
# wc hg16-1mb.bed

# mv ~/Downloads/hg19-kc.tsv ~/qb25-answers/week1 #can also move manually from Downloads to ~/qb25-answers/week1
# wc hg19-kc.tsv

cut -f1-3,5 hg16-kc.tsv > hg16-kc.bed
head hg16-kc.bed

# Count number of genes in a 1mb window
bedtools intersect -c -a hg16-1mb.bed -b hg16-kc.bed > hg16-kc-count.bed

# How many genes are in hg19?
wc hg-19kc.bed
# 80,270 genes in hg19 

# Find genes that are in hg19 but not in hg16
bedtools intersect -v -a hg19-kc.bed -b hg16-kc.bed > uniqueToHG19.bed
# 42,717 genes unique to HG19

# Why are some of these genes in hg19 but not hg16?
# hg19 likely had more advanced sequencing and analysis methods, so there are genes that were previously unsequencable now in the updated sequence

# How many genes are in hg16?
wc hg16-kc.bed
# 21,365 genes

# Find genes that are in hg16 but not in hg19
bedtools intersect -v -a hg16-kc.bed -b hg19-kc.bed > uniqueToHG16.bed
# 3,460 genes unique to HG16

# Why are some genes unique to hg16?
# My guess is that hg19 reannotates features that it can better localize or read, so perhaps there
# are features that were in one locus in hg16 that was positioned somewhere slightly different in hg19.
# The 'intersect' approach doesn't detect annotation names, only locations, so these genes would appear
# as unique annotations to hg16.
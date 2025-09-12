#!/bin/bash

wget https://hgdownload.soe.ucsc.edu/goldenPath/hg19/bigZips/hg19.chrom.sizes

grep -v _ hg19.chrom.sizes | sed 's/M/MT/' > hg19-main.chrom.sizes

bedtools makewindows -g hg19-main.chrom.sizes -w 1000000 > hg19-1mb.bed
wc hg19-1mb.bed

# mv ~/Downloads/hg19-kc.tsv ~/qb25-answers/week1 #can also move manually from Downloads to ~/qb25-answers/week1
wc hg19-kc.tsv

cut -f1-3,5 hg19-kc.tsv > hg19-kc.bed
head hg19-kc.bed

# Count number of genes in a 1mb window
bedtools intersect -c -a hg19-1mb.bed -b hg19-kc.bed > hg19-kc-count.bed



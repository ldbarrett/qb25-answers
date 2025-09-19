#!/bin/bash

# Determine which gene has most SNPs
# bedtools intersect documentation describes the '-c' option as meaning: 
# "For each entry in A, report the number of overlaps with B"
# We want to count for each gene (A) the number of SNPs in it (B). A gene overlaps with the SNP dataset as many times as there are SNPs in that feature
bedtools intersect -c -a hg19-kc.bed -b snps-chr1.bed > hg19-kc-SNPcount.bed

sort -k5 -nr hg19-kc-SNPcount.bed > hg19-kc-SNPcountSorted.bed
# This sorts based on the 5th column, which is my counts of overlaps with SNPs
# Output Gene is:
# ENST00000490107.6_7, also known as SMYD3, position hg19 chr1:245,912,649-246,670,581
# A size of 757,933bp and 12 exons

# This seems to me like a very large gene, but it codes for a normal sized protein (488aa), meaning there
# are very large introns, which are more likely able to be mutated without drastically altering the gene product's
# function. This aligns with the visual depiction of introns and exons in the UCSC browser.


# Create a subset of SNPs
bedtools sample -n 20 -seed 42 > subsetOfSNPs.bed
# sort that subset
bedtools sort -i subsetOfSNPs.bed > sortedSubsetOfSNPs.bed
# Use bedtools sort to sort hg19-kc.bed
bedtools sort -i hg19-kc.bed > sortedHG19-kc.bed
# Use closest to on the two sorted files
bedtools closest -d -t first -a sortedHG19-kc.bed -b sortedSubsetOfSNPs.bed  > snpDistances.bed

# Sort the snpDistances file
sort -k11 -n snpDistances.bed > sortedSNPdistances.bed

# Create a file with only SNPs outside the genes
awk '$11>0' sortedSNPdistances.bed > sortedSNPdistancesOutside.bed
# There are 7251 SNPs outside the genes

# Create a file with only SNPs inside the genes
awk '$11<1' sortedSNPdistances.bed > sortedSNPdistancesInside.bed
# There are 73018 SNPs inside the genes

# The range of distances from the SNPs outside the genes
# Furthest is 36227401, nearest is 1664
# The range is 36225737bp
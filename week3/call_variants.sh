#!/bin/bash

# tar -xzvf BYxRM_bam.tar # My computer unzipped the tar.gz file for me

# Step 1.1
for sample in A01_09 A01_11 A01_23 A01_24 A01_27 A01_31 A01_35 A01_39 A01_62 A01_63
do
    echo "***" $sample
    samtools index $sample.bam
done

# Question 1.1

touch read_counts.txt
for sample in A01_09 A01_11 A01_23 A01_24 A01_27 A01_31 A01_35 A01_39 A01_62 A01_63
do
    samtools view -c $sample.bam >> read_counts.txt
done

## See read_counts.txt for the number of reads in each file!


# Step 1.2
touch bamListFile.txt

for sample in A01_09 A01_11 A01_23 A01_24 A01_27 A01_31 A01_35 A01_39 A01_62 A01_63
do
    echo $sample.bam >> bamListFile.txt
done


# FreeBayes commands

freebayes -f /Users/cmdb/qb25-answers/week2/genomes/sacCer3.fa -L bamListFile.txt --genotype-qualities -p 1 > unfiltered.vcf
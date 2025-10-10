#!/usr/bin/env python3

## Question 3.1
# Wine Strain: 24, 27, 31, 62, and 63 have the most abundant SNPs in this locus, so I suspect they derive from the wine strain
# Lab Strain: 9, 11, 23, 35, and 39 have relatively fewere SNPs than the other 5 strains at this locus, so I suspect they derive from the lab strain at this locus


# sample IDs (in order, corresponding to the VCF sample columns)
sample_ids = ["A01_62", "A01_39", "A01_63", "A01_35", "A01_31",
              "A01_27", "A01_24", "A01_23", "A01_11", "A01_09"]

# open the VCF file
vcf = open("biallelic.vcf")
output = open("gt_long.txt",'w')

for line in vcf:
    if line.startswith("#"):
        continue
    fields = line.split('\t')
    chrom = fields[0]
    pos = fields[1]

    sampleIndex = 9
    for sample in sample_ids:
        data = fields[sampleIndex]
        if data.startswith('0'):
            genotype = 0
        elif data.startswith('1'):
            genotype = 1
        else:
            continue
        
        output.write(f'{sample}\t{chrom}\t{pos}\t{genotype}\n')
        sampleIndex += 1

    


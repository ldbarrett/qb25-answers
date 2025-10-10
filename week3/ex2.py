#!/usr/bin/env python3

fs = open("AF.txt",'w')
fsDepth = open("DP.txt",'w')

for line in open("biallelic.vcf"):
    if line.startswith('#'):
        continue
    fields = line.rstrip('\n').split('\t')

    # Step 2.2: Allele Frequency
    alleleInfo = fields[7] # Semicolon delimited string
    alleleInfoSplit = alleleInfo.split(';') # Splits up AlleleInfo
    alleleFrequencyEquals = alleleInfoSplit[3]
    af = alleleFrequencyEquals.split('=')[1] # Takes AF=_._ and stores it
    fs.write(af)
    fs.write('\n')

    # See ex2.R for Questions 2.1 and 2.2

    # Step 2.3: Depth
    depthDelimited = fields[9].split(':')[2]
    fsDepth.write(depthDelimited)
    fsDepth.write('\n')
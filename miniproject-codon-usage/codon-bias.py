#!/usr/bin/env python3

import sys
import fasta
import codons

counts = {}

filename = sys.argv[1]
letter = sys.argv[2]

fs = open(filename)

for ident,sequence in fasta.FASTAReader(fs):
    for bases in range(0,len(sequence),3):
        codon = sequence[bases:bases+3]
        if codon in codons.forward and codons.forward[codon] == letter: # If current codon exists and encodes the Amino Acid specified at command line:
            if codon in counts.keys():
                counts[codon] += 1
            else:
                counts[codon] = 1

# print(counts)

output = open(f'bias-{letter}.tsv','w')

for codonKey in counts:
    output.write(f"{codonKey}\t{counts[codonKey]}\n")

            

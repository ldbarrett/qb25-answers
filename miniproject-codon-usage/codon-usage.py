#!/usr/bin/env python3

import sys
import fasta
import codons

# print (codons.forward)
aas = {}

fs = open(sys.argv[1])
identities = [] # Using this to count how many contigs there are in a file. This should match the number of stop codons are in a given library.
totallength = 0

for ident, sequence in fasta.FASTAReader(fs):
    # print(ident)
    # print(len(sequence))
    totallength += len(sequence)
    identities.append(ident)
    for i in range(0,len(sequence),3):
        codon = sequence[i:i+3]
        # print(codon)
        if codon in codons.forward:
            if codons.forward[codon] in aas:
                aas[codons.forward[codon]] += 1
            else:
                aas[codons.forward[codon]] = 1

sorted_aas = dict(sorted(aas.items())) # I sorted because the dictionary key order might vary 
                                       # across FASTA files because the order that amino acids are added 
                                       # to the abundance dictionary is sequence dependent

print(totallength)
# print(sorted_aas)
# print(len(identities)) # Check how many contigs in a file, this should match stop codon count for membrane.fa and cytoplasm.fa files, since they're all full, in-frame coding sequences

    
        
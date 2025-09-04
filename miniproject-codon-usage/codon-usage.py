#!/usr/bin/env python3

import sys
import fasta
import codons

aas = {} # Parent dictionary; Keys will be the filename of the argument I input, values will be the abundance dictionary for that FASTA file
fileCount = 1
# Credit to Grayden for this idea, I would have otherwise tried to define the other abundance dictionaries for
# each file from the get-go, before iterating through sys.argv.

for filename in sys.argv:
    if filename.startswith('./'):
        continue
    aas[filename] = {}

    # print (codons.forward)

    fs = open(filename)
    # identities = [] # Using this to count how many contigs there are in a file. This should match the number of stop codons are in a given library.
    # totallength = 0

    for ident, sequence in fasta.FASTAReader(fs):
        # print(ident)
        # print(len(sequence))
        # totallength += len(sequence)
        # identities.append(ident)
        for i in range(0,len(sequence),3):
            codon = sequence[i:i+3]
            # print(codon)
            if codon in codons.forward:
                if codons.forward[codon] in aas[filename]:
                    aas[filename][codons.forward[codon]] += 1
                else:
                    aas[filename][codons.forward[codon]] = 1

    sorted_aas = dict(sorted(aas[filename].items())) # I sorted because the dictionary key order might vary 
                                        # across FASTA files because the order that amino acids are added 
                                        # to the abundance dictionary is sequence dependent
    aas[filename] = sorted_aas

    # print(totallength)
    # print(aas[filename])
    # print(len(identities)) # Check how many contigs in a file, this should match stop codon count for membrane.fa and cytoplasm.fa files, since they're all full, in-frame coding sequences

output = open('cyto-v-mem.tsv','w')

single_letter_aminoacids = codons.reverse.keys()
sortedSingleLetterCodes = sorted(single_letter_aminoacids)
# print(sortedSingleLetterCodes)

for letter in sortedSingleLetterCodes:
    output.write(f"{letter}\t")
    for abundanceCounts in aas:
        output.write(str(aas[abundanceCounts][letter]))
        output.write('\t')
    output.write('\n')



output.close()

        
            
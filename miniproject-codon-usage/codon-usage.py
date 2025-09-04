#!/usr/bin/env python3

import sys
import fasta
import codons

aas = {} # Parent abundance dictionary; Keys will be the filename of the argument I input, values will be the abundance dictionary for that FASTA file
n50 = {} # Parent n50 dictionary:
# Credit to Grayden for this idea, I would have otherwise tried to define the other abundance dictionaries for
# each file from the get-go, before iterating through sys.argv.

for filename in sys.argv[1:]:
    aas[filename] = {}
    n50[filename] = {}

    # print (codons.forward)

    fs = open(filename)
    # identities = [] # Using this to count how many contigs there are in a file. This should match the number of stop codons are in a given library.

    totallength = 0
    contigLengths = []

    for ident, sequence in fasta.FASTAReader(fs):
        # print(ident)
        # print(len(sequence))
        totallength += len(sequence)
        contigLengths.append(len(sequence))
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

    contigLengths.sort(reverse=True) # Sorts contig length list
    iteratingSum = 0
    for index in contigLengths: # iterates through contig length list from largest to smallest
        iteratingSum += index
        if iteratingSum > (totallength / 2): # Finds the smallest contig that, when summed with preceding sequence lengths, yields a sequence >50% of the total length
            n50[filename] = index # stores N50 length into the external n50 dictionary as the value corresponding to the key of that filename
            break


    # print(totallength)
    # print(aas[filename])
    # print(len(identities)) # Check how many contigs in a file, this should match stop codon count for membrane.fa and cytoplasm.fa files, since they're all full, in-frame coding sequences

output = open('cyto-v-mem.tsv','w')

single_letter_aminoacids = codons.reverse.keys()
sortedSingleLetterCodes = sorted(single_letter_aminoacids)
# print(sortedSingleLetterCodes)

for letter in sortedSingleLetterCodes:
    output.write(f"{letter}\t")
    for abundanceCounts in aas.keys():
        # print(aas[abundanceCounts]) # From Debugging — there are no tryptophans in subset.fa so that threw an error
        if letter in aas[abundanceCounts]:
            output.write(str(aas[abundanceCounts][letter]))
            output.write('\t')
        else:
            output.write('0')
            output.write('\t')
    output.write('\n')

output.close()

## FEEL FREE TO IGNORE THIS
# I misclicked and repeated a step from Mini Project #1 here when we don't actually need to calculate n50

n50output = open('n50s.tsv','w')

for file in n50:
    n50output.write(f"{file}\t")
    n50output.write(f"{n50[file]}\t")
    n50output.write('\n')



        
            
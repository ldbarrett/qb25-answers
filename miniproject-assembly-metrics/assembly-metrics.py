#!/usr/bin/env python3
import sys
import fasta

fs = open(sys.argv[1])

identities = []
sequences = []
totalLength = 0
contigLengths = []

for ident, sequence in fasta.FASTAReader(fs):
    identities.append(ident)
    sequences.append(sequence)
    totalLength += len(sequence)
    contigLengths.append(len(sequence))

# print(f"Number of contigs: {len(identities)}")
# print(f"Total length: {totalLength}")
# print(f"Average length: {totalLength / len(identities):.2f}")

contigLengths.sort(reverse=True)
# print(contigLengths)

iteratingSum = 0

# print(contigLengths[0]/totalLength)
for element in contigLengths:
    iteratingSum += element
    # print(iteratingSum)
    if iteratingSum > (totalLength/2):
        print(f"sequence length of the shortest contig at 50% of the total assembly length is {element}")
        break
    
    
    



    

# print(Number of )
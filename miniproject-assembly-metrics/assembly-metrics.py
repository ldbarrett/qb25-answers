#!/usr/bin/env python3
import sys
import fasta

fs = open(sys.argv[1])

identities = []
sequences = []
totalLength = 0

for ident, sequence in fasta.FASTAReader(fs):
    identities.append(ident)
    sequences.append(sequence)
    totalLength += len(sequence)

print(f"Number of contigs: {len(identities)}")
print(f"Total length: {totalLength}")
print(f"Average length: {totalLength / len(identities):.2f}")
# print(contigs)

    

# print(Number of )
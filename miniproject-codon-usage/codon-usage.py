#!/usr/bin/env python3

import sys
import fasta

fs = open(sys.argv[1])

for ident, sequence in fasta.FASTAReader(fs):
    print(ident)
    # print(len(sequence))
    for i in range(0,len(sequence),3):
        codon = sequence[i:i+3]
        print(codon)
    break
        
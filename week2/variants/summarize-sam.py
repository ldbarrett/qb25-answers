#!/usr/bin/env python3

import sys


chromAlignmentCounts = {}
mismatchCounts = {}
samfilename = sys.argv[1]

fs = open(samfilename)
for line in fs:
    if line.startswith("@"):
        continue
    splitLine = line.split()
    chrom = splitLine[2]
    for element in splitLine:
        if element.startswith('NM'):
            mismatch = element
            mismatchkey = mismatch.strip('NM:i:')
            if mismatchkey in mismatchCounts:
                mismatchCounts[mismatchkey] += 1
            else:
                mismatchCounts[mismatchkey] = 1
    # print(line)
    # print(mismatchCounts)
    # break
    if chrom in chromAlignmentCounts:
        chromAlignmentCounts[chrom] += 1
    else:
        chromAlignmentCounts[chrom] = 1

print(chromAlignmentCounts)
# print(mismatchCounts)
sortedMismatchCounts = dict(sorted(mismatchCounts.items(), key = lambda item: item[1]))
print('\n')
print(sortedMismatchCounts)

# Output: {'chrI': 8935, 'chrVIII': 32411, '*': 3135, 'chrXV': 65696, 'chrVII': 67253, 'chrII': 48852, 'chrX': 44133, 'chrXII': 66342, 'chrXIII': 56740, 'chrIV': 93309, 'chrIII': 19671, 'chrV': 33089, 'chrXI': 41299, 'chrXIV': 47048, 'chrVI': 12330, 'chrIX': 23597, 'chrXVI': 57075, 'chrM': 19152}

    
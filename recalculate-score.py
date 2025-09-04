#!/usr/bin/env python3

data = open('ce11_genes.bed')

newData = open('new_scores_ce11_genes.bed','w')

for line in data:
    line = line.strip('\n')
    fields = line.split('\t')
    print(fields)
    # print(fields[2] + fields[4])
    size = int(fields[2]) - int(fields[1])
    oldScore = int(fields[4])
    strandedness = 0
    if fields[5] == '+':
        strandedness = 1
    if fields[5] == '-':
        strandedness = -1
    newScore = oldScore * size * strandedness
    newData.write(f"{fields[0]}\t{fields[1]}\t{fields[2]}\t{fields[3]}\t{newScore}\t{fields[5]}\n")

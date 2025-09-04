#!/usr/bin/env python3

fs = open("GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_tpm.gct")

# Skip first two lines
fs.readline()
fs.readline()

headerLine = fs.readline()
header = headerLine.split('\t')

dataLine = fs.readline()
data = dataLine.split('\t')

dict = {}
for i in range(len(header)):
    dict[header[i]] = data[i]

print(data[0:10])
# print(data[0])
# print(dict)

metadataFile = open("GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt")

expressionCounts = 0
firstThreeExpressingTissues = []

for line in metadataFile:
    line = line.strip('\n')
    fields = line.split('\t')
    SAMPID = fields[0]
    if SAMPID in dict:
        print(f"{SAMPID}\t{dict[SAMPID]}\t{fields[6]}\n")
        if float(dict[SAMPID]) > 0 and expressionCounts < 3:
            firstThreeExpressingTissues.append(fields[6])
            expressionCounts += 1

print(f"The first three tissues to show non-zero expression are {firstThreeExpressingTissues[0]}, {firstThreeExpressingTissues[1]}, and {firstThreeExpressingTissues[2]}")




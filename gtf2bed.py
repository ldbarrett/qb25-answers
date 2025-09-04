#!/usr/bin/env python3
import gzip

input_filename = 'gencode.v46.basic.annotation.gtf.gz'
fs = gzip.open('gencode.v46.basic.annotation.gtf.gz','rb')

output_filename = input_filename.replace('.gtf.gz','.bed')
print(output_filename)
output = open(output_filename,'w')

for line in fs:
    line = line.decode()
    line = line.strip('\n')
    if line.startswith('##'): # ignores starting lines
        continue
    fields = line.split('\t')
    
    if fields[2] == 'gene': # only prints outputs for gene features
        chr = fields[0]
        start = int(fields[3]) - 1 # converts to zero-base system for loci
        stop = int(fields[4]) - 1
        description = fields[8].split(';') # takes something like gene_id ...; gene_type ...; gene_name "DDX11L2";... and splits it based on semicolons
        name = description[2] # gene_name "______" is always the third element of the list made above
        name = name.split(' ')[2].strip('"') # takes the above, splits it into a list, chooses the actual name and then strips off the double quotes
        output.write(f"{chr}\t{start}\t{stop}\t{name}\n")
        


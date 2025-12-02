#!/usr/bin/env python3
import numpy as np
import random
from scipy.stats import poisson
from scipy.stats import norm

genome_length = 1000000
coverage = 30
coverageString = str(coverage)

genome_coverage = np.zeros(genome_length,dtype = int)
# print(genome_coverage)
len_read = 100
num_reads = (genome_length * coverage)/len_read


for i in range(int(num_reads)):
    startpos = random.randint(1,(genome_length-len_read))
    endpos = startpos + len_read
    genome_coverage[startpos:endpos] = genome_coverage[startpos:endpos] + 1
    # print(genome_coverage[startpos:endpos])

# print(genome_coverage)
maxcoverage = max(genome_coverage)
print(maxcoverage)
xs = list(range(0,maxcoverage+1))

poisson_estimates = poisson.pmf(xs,coverage,loc=0)
normal_estimates = norm.pdf(xs,coverage,np.sqrt(coverage))
print(sum(poisson_estimates))
print(normal_estimates)

poissonOut = open(f"{coverageString}_poissonEstimates.txt",'w')
for element in poisson_estimates:
    poissonOut.write(str(element*genome_length)+"\n")

normalOut = open(f"{coverageString}_normalEstimates.txt",'w')
for element in normal_estimates:
    normalOut.write(str(element*genome_length)+"\n")

coverageOut = open(f"{coverageString}_coverageMap.txt",'w')
for i in genome_coverage:
    coverageOut.write(str(i)+"\n")
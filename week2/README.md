# Week 2 Assignment
## Exercise 1
Code:
```
cd genomes
 cp ~/Data/References/sacCer3/sacCer3.fa.gz .
 gunzip sacCer3.fa.gz
 bowtie2-build sacCer3.fa sacCer3

 cd variants
 bowtie2 -p 4 -x ../genomes/sacCer3 -U ~/Data/BYxRM/fastq/A01_01.fq.gz > A01_01.sam # Makes A01_01.sam
 samtools sort -o A01_01.bam A01_01.sam   # Makes A01_01.bam
 samtools index A01_01.bam  # Makes A01_01.bam.bai

 samtools idxstats A01_01.bam > A01_01.idxstats # Produces IDX Stats file
```

Genotype Calls at 4 loci:
chrI:27915 - C
chrI:28323 - A
chrI:28652 - T
chrI:29667 - A


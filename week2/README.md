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


## Exercise 2
Zooming into the loci in the ChrI:27,000-30,000 range can inform us which SNPs come from which strains when compared to the BYxRM_GenoData.txt dataset. For example, at chrI:27915, A01_01, A01_03, and A01_04 contain T to C SNPs, while 02, 05, and 06 have T's at that locus. Looking at the haplotype data shows that the researchers who compiled this dataset
predict that the loci at chrI:27,915 in A01_01, _03, and _04 came from the R strain, while those at A01_02, _05, and _06 came from the B strain.

This pattern holds when we zoom out. At different SNP loci, certain samples have SNPs assigned to R or B and others have the 'reference' nucleotide, which aligns with our haplotype file.


## Exercise 4
### `minimap2` command: 
```minimap2 -x 'map-ont' -a ../genomes/sacCer3.fa ../rawdata/ERR8562478.fastq > longreads.sam ```

-a ensures the output is in a .sam format
-x 'map-ont' ensures it's set to read Oxford Nanopore Technology reads
```../genomes/sacCer3.fa``` is the path to the target.fa
```../rawdata/ERR8562478.fastq``` is the path to the query.fa
And I output everythihng to ```longreads.sam```

### Sort `longreads.sam`
samtools sort -o longreads.bam longreads.sam
samtools index longreads.bam
samtools idxstats longreads.bam > longreads.idxstats


## Exercise 5
### hisat2 Commands
fasterq-dump -p SRR10143769  
hisat2-build ../genomes/sacCer3.fa sacCer3
hisat2 -p 4 -x ../genomes/sacCer3 -U ../rawdata/SRR10143769.fastq -S rna.sam

samtools sort -o rna.bam rna.sam
samtools index rna.bam

It seems like the 3' ends of the transcripts are getting the most coverage. This can probably be explained by the method used to acquire reads on a transcript. Perhaps the 5' end is lost because of an early DNA binding event to the 5' tails (to amplify the signal of mRNA) and so the stuff that actually gets sequenced starts beyond there, closer to the 3' end?




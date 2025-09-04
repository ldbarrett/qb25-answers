# Mini Project 2
## We'll be assessing codon usage from fasta data

### Response 1
So far I've built a fasta reader and have begun iterating through that. I have put a break at the end of the code block for my outer for loop (which iterates through the fastareader object), so my output should only be derived from the first contig. My output when I print out the 'codon' object for each trinucleotide is many lines of three nucleotides. Each line is exactly three nucleotides, which makes sense because I had checked the length of the sequence and found it to be 405 nucleotides, which is a multiple of 3. The first and last couple of amino acids from the list of 135 is:

ATG
CCG
TTC
CTG
GAG
CTG
GAC
...
CTC
TTC
ATT
TAT
TTC
ATA
TGA

### Response 2
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
Now I've made a dictionary aas to count abundance of each amino acid in a given FASTA file. Using the subset.fa file, I get the following abundances:

{'*': 1, 'A': 17, 'C': 4, 'D': 5, 'E': 10, 'F': 7, 'G': 12, 'H': 3, 'I': 7, 'K': 6, 'L': 17, 'M': 3, 'N': 5, 'P': 13, 'Q': 3, 'R': 9, 'S': 13, 'T': 11, 'V': 8, 'Y': 1}

For cytoplasm.fa, the abundances are:

{'*': 100, 'A': 3183, 'C': 954, 'D': 2252, 'E': 3544, 'F': 1610, 'G': 2663, 'H': 1273, 'I': 1907, 'K': 2570, 'L': 4769, 'M': 988, 'N': 1704, 'P': 2762, 'Q': 2166, 'R': 2622, 'S': 3808, 'T': 2633, 'V': 2525, 'W': 535, 'Y': 1201}

For membrane.fa, the abundances are:

{'*': 100, 'A': 3364, 'C': 1031, 'D': 2039, 'E': 2953, 'F': 1961, 'G': 3143, 'H': 1224, 'I': 2365, 'K': 2207, 'L': 5044, 'M': 1010, 'N': 1797, 'P': 3053, 'Q': 1879, 'R': 2511, 'S': 4272, 'T': 3468, 'V': 2921, 'W': 595, 'Y': 1438}

I trust that these abundances are correct because the number of contigs in cytoplasm.fa and membranes.fa matches the number of stop codons in each. In these files, each contig is a full-length, in-frame coding sequence that ends in a stop codon, and I kept track of the number of contigs by appending each contig identifer to a list called ```identities```. These numbers match up for cytoplasm.fa and membrane.fa. And in the case of subset.fa, the head command we used to generate the file cuts off the second contig sequence's stop codon, so we predictably have only one stop codon.

As for whether these results make sense, I would predict that membrane integral protein sequences (from membranes.fa) have a higher abundance of hydrophobic proteins than cytosolic proteins, since they need to be exposed to a hydrophobic intramembrane space. Each of the hydrophobic residues (A, V, L, I, M, F, W, and P) appear more in membranes.fa than cytoplasm.fa. This is admittedly a hand-wavey explanation, since a couple of these differences are on the order of ~5% and there are ~5% more codons in the membrane.fa file than in cytoplasm, but at least it doesn't disagree with our expectations.
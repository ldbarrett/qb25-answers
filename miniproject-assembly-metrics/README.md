# Mini Project 1
## We'll be assessing assembly metrics from sequencing data

## FASTA Download URLs
- https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA248909/caenorhabditis_remanei.PRJNA248909.WBPS19.genomic.fa.gz  (INFO: 115mb unzipped; Number of contigs: 1591; Total length: 118549266; Average length: 74512.42)
- https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA248911/caenorhabditis_remanei.PRJNA248911.WBPS19.genomic.fa.gz (INFO: 121mb unzipped; Number of contigs: 912; Total length: 124541912; Average length: 136559.11)
- https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA53967/caenorhabditis_remanei.PRJNA53967.WBPS19.genomic.fa.gz (INFO: 141mb unzipped; Number of contigs: 3670; Total length: 145442736; Average length: 39630.17)
- https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA577507/caenorhabditis_remanei.PRJNA577507.WBPS19.genomic.fa.gz (INFO: 127mb unzipped, Number of contigs: 187, Total length: 130480874, Average length: 697758.68)

## Instructions for ~/qb25-answers/miniproject-assembly-metrics/running assembly-metrics.py
- Download a FASTA file to the local directory
- If it's zipped (e.g. with gzip), unzip the file
- Run assembly-metrics.py with the name of the file of interest as the first argument of the command ```./assembly-metrics.py examplefastafile.fa```
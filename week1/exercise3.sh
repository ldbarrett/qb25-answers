#!/bin/bash

## Responses to ChromHMM viewer questions
# You see very high chromatin accessibility (and classification as active promoters/weak promoters, as low as enhancers) near transcription start sites in TP53. Weaker transcription is the categorization in introns, indicative of low chromatin accessibility
# SHH is generally inaccessible compared to TP53's locus. Its most active section is a poised promoter (3rd most accessible) and most is in 12_repressed or 13_heterochromatin
# In the TP53 gene, an insulator position appears in what is a 10_TxnElongation region in NHLF, which means it's more accessible. This is interesting and could lead to tissue specific regulation.


# I downloaded my two .bed files from UCSC and manually moved them to my ~/qb25-answers/week1 folder

# Separate .bed files into Active and Repressed features based on cell type

grep 1_Active nhek.bed > nhek-active.bed
grep 12_Repressed nhek.bed > nhek-repressed.bed

grep 1_Active nhlf.bed > nhlf-active.bed
grep 12_Repressed nhlf.bed > nhlf-repressed.bed

# Construct a bedtools command to test where there is any overlap between 1_Active and 12_Repressed in a given condition (aka mutually exclusive)
bedtools intersect -a nhek-active.bed -b nhek-repressed.bed > mutuallyExclusiveNHEK.bed
bedtools intersect -a nhlf-active.bed -b nhlf-repressed.bed > mutuallyExclusiveNHLF.bed

# mutuallyExclusiveNHEK.bed and mutuallyExclusiveNHLF.bed are both empty! No regions are both active and repressed at the same time

# bedtools command to find genes active in both NHEK and NHLF
bedtools intersect -a nhek-active.bed -b nhlf-active.bed > activeAcrossTissues.bed
# 12174 genes active in both tissues

# bedtools command to find genes active in NHEK but not NHLF
bedtools intersect -v -a nhek-active.bed -b nhlf-active.bed > exclusivelyActiveInNHEK.bed
# 2405 genes active only in NHEK

# 12174 + 2405 = 14579, which is more gene counts than there are active genes in NHEK (14,013)
# If we modify the first command to also contain a -u option, then it should only report an active gene from nhek-active 
# if any active genes are found in that feature in nhlf-active
bedtools intersect -u -a nhek-active.bed -b nhlf-active.bed > activeAcrossTissuesSingleCount.bed
# This yields 11608 genes active in both NHEK and NHLF, and 11,608 + 2,405 = 14,013, which is the correct summation

# Different Overlap Parameter Functions
bedtools intersect -f 1 -a nhek-active.bed -b nhlf-active.bed > activeAcrossTissuesLowercaseF1.bed # First Feature: Chr1:25558413-25559413
bedtools intersect -F 1 -a nhek-active.bed -b nhlf-active.bed > activeAcrossTissuesUppercaseF1.bed # First Feature: Chr1:19923013-19924213
bedtools intersect -f 1 -F 1 -a nhek-active.bed -b nhlf-active.bed > activeAcrossTissuesUpperAndLowercaseF1.bed # First Feature: Chr1:1051137-1051537

# For just -f 1, all of the NHEK feature (the active promoter) fits inside the NHLF feature, which is larger. This makes sense because
# -f 1 means each overlap must span 100% of the A input feature (in this case NHEK)

# For just -F 1, all of the NHLF feature (another active promoter) fits inside the NHEK feature. This makes sense, it's the opposite of the previous

# For both -f 1 and -F 1, the features are identical, because the overlap needs to be 100% of both the A (NHEK) and B (NHLF) feature

# Identify regions that are:
# ActiveNHEK, ActiveNHLF
bedtools intersect -a nhek-active.bed -b nhlf-active.bed > activeAcrossTissues.bed # From earlier question
# chr1:19,921,812-19,925,414

# Active NHEK, RepressedNHLF
bedtools intersect -a nhek-active.bed -b nhlf-repressed.bed > activeNHEKrepressedNHLF.bed
# chr1:1,980,739-1,981,941

# RepressedNHEK, RepressedNHLF
bedtools intersect -a nhek-repressed.bed -b nhlf-repressed.bed > repressedNHEKrepressedNHLF.bed
# chr1:11,537,413-11,538,213







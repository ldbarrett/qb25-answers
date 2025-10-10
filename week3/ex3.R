library(tidyverse)
variants <- read.table("~/qb25-answers/week3/gt_long.txt")
colnames(variants) <- c("Sample","Chromosome","Position","Genotype")

variants_rearranged <- variants %>%
    mutate(
      sample_index = as.numeric(factor(Sample)),
      offset = Genotype + (sample_index-1) * 2
         )


chrII_variants <- variants[variants$Chromosome == "chrII", ]

A01_62_chrII_variants <- chrII_variants[chrII_variants$Sample == "A01_62", ]

A01_62_variants <- variants[variants$Sample == "A01_62", ]

p1 <- ggplot(A01_62_chrII_variants, aes(x = Position, y = factor(Genotype),color=factor(Genotype)))+
  geom_point()+
  labs(
    x = "Genomic Position",
    y = "Genotype"
  )


# Question 3.2
# I do notice patterns, I notice one long stretch of genotype 0 (reference SNPs) and two stretches of genotype 1 (non-reference SNPs)
# In addition, there are a lot of one-off dots (or at least close, sparse dots that appear as one on the plot) wehre individual SNPs
# from one genotype are in the middle of a long stretch from the other. As such, I suspect the transitions between long stretches of
# genotypes are sites of recombination, but there may be reads that appear as SNPs of one genotype in the midst of a long
# stretch of the opposite genotype, indicating that either misreads exist or there is more SNP variety in these two strains than
# initially predicted, since we would not expect two recombination events so close together that these individual SNPs are recombined without
# any others.


p2 <- ggplot(A01_62_variants, aes(x = Position, y = factor(Genotype),color=factor(Genotype)))+
geom_point()+
facet_grid(scales = "free_x", space = "free_x",Chromosome ~ .)+
labs(
  x = "Genomic Position",
  y = "Genotype"
)

p3 <- ggplot(variants_rearranged, aes(x = Position, y = offset, color = factor(Genotype)))+
  geom_point()+
  facet_grid(scales = "free_x", space = "free_x", Chromosome ~ .)+
  labs(
    x = "Genomic Position",
    y = "Genotype"
  )


ggsave("~/Desktop/chrII_A01_62.png", plot = p1, width = 5, height = 2.5)
ggsave("~/Desktop/A01_62.png", plot = p2, width = 10, height = 10)
ggsave("~/Desktop/AllSamples.png", plot = p3, width = 15, height = 20)


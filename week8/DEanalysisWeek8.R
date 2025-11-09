library(tidyverse)
library(broom)
library(DESeq2)
## Exercise 1
# Step 1.1
counts_df <- read_delim("~/qb25-answers/week8/gtex_whole_blood_counts_downsample.txt")
counts_df <- column_to_rownames(counts_df, var = "GENE_NAME")
metadata_df <- read_delim("~/qb25-answers/week8/gtex_metadata_downsample.txt")

# Step 1.2
# Check that samples are in the same order 
table(colnames(counts_df) == rownames(column_to_rownames(metadata_df, var = "SUBJECT_ID")))

deseqobject <- DESeqDataSetFromMatrix(countData = counts_df,
                              colData = metadata_df,
                              design = ~ SEX + AGE + DTHHRDY)

# Step 1.3
vsd <- vst(deseqobject)
PCA_sex <- plotPCA(vsd, intgroup = "SEX")
PCA_age <- plotPCA(vsd, intgroup = "AGE")
PCA_death <- plotPCA(vsd, intgroup = "DTHHRDY")

ggsave("~/qb25-answers/week8/PCA_sex.png",plot = PCA_sex)
ggsave("~/qb25-answers/week8/PCA_age.png",plot = PCA_age)
ggsave("~/qb25-answers/week8/PCA_death.png",plot = PCA_death)

## Interpretation:
# PC1 captures 48% variance and PC2 7% variance
# PC1 seems to be associated with Age and Cause of Death, which seems to make sense, since
# older people are more likely to die of similiar causes, and I imagine there are aging-related
# changes in global transcription. 

## Exercise 2
# Step 2.1
vsd_df <- assay(vsd) %>%
  t() %>%
  as_tibble()

vsd_df <- bind_cols(metadata_df, vsd_df)

m1 <- lm(formula = WASH7P ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>%
  tidy()

## Interpretation:
# WASH7P does show significant sex-differential expression. I believe it is in the direction of increased male expression,
# since the coefficient with sexMALE as the variable is positive.

m2 <- lm(formula = SLC25A47 ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>%
  tidy()

## Interpretation:
# As with WASH7P, I believe this gene has sex-differential expression in the male direction, since its estimated
# coefficient is positive

# Step 2.2
deseqobject <- DESeq(deseqobject)

# Step 2.3
sex_res <- results(deseqobject, name = "SEX_male_vs_female") %>%
  as_tibble(rownames = "GENE_NAME")

filtered_sex_res <- sex_res %>%
  filter(padj < 0.1)
# after filtering for padj < 0.1, the filtered_sex_res tibble has 262 rows,
# so there are 262 genes that exhibit differential expression between males and females at 10% FDR

gene_locations <- read_delim("~/qb25-answers/week8/gene_locations.txt")

sex_res <- left_join(sex_res,gene_locations, by="GENE_NAME")

sex_res <- sex_res %>%
  arrange(sex_res$padj)


## The hits that are the most enriched in male samples are on the Y chromosome, and those that are most enriched
## in the female samples are generally (but not always) on the X chromosome. There are some genes on
## Chr2 and Chr14 that are each upregulated in males. There are more genes upregulated in males towards the top of the list
## This may be because females don't have Y chromosomes, while men have one X chromosome. The top female-enriched gene
## is XIST, which is involved in x-chromosome inactivation

sex_res_wash7p <- sex_res %>%
  filter(GENE_NAME=="WASH7P")
sex_res_SLC25A47 <- sex_res %>%
  filter(GENE_NAME=="SLC25A47")

## In both of these cases, the genes are enriched in males, which aligns with my result from 2.1.
## Additionally, the difference is fold-expression is greater for SLC25A47 than in WASH7P, which aligns
## with what we observed in the homemade analysis

## I would predict that if we had a very strict FDR (~1%), we would see an enrichment of false negatives, since 
## we're using stricter statistical thresholds, meaning we'll see things with padj between 0.01 and 0.05 that
## would not be deemed significant, though they may be in practice. Conversely, at higher FDR we'd expect more 
## false positives. Higher sample size is likely to confer more statistical power given that effect size is minimal
## across batches of samples. There is a dependence of the two on each other that determines the power we have
## for analysis, in which we gain from high sample size and low batch effects.

# 2.4
death_res <- results(deseqobject, name = "DTHHRDY_ventilator_case_vs_fast_death_of_natural_causes") %>%
  as_tibble(rownames = "GENE_NAME")

filtered_death_res <- death_res %>%
  filter(padj < 0.1)
# 16,069 genes are differentially expressed due to death classification at 10% FDR


# 2.5
shuffled_metadata <- metadata_df
shuffled_metadata$SEX <- sample(shuffled_metadata$SEX,replace = FALSE)

deseq_shuffled <- DESeqDataSetFromMatrix(countData = counts_df,
                                      colData = shuffled_metadata,
                                      design = ~ SEX + AGE + DTHHRDY)

deseq_shuffled <- DESeq(deseq_shuffled)

sex_res_shuffled <- results(deseq_shuffled, name = "SEX_male_vs_female") %>%
  as_tibble(rownames = "GENE_NAME")

filtered_sex_res_shuffled <- sex_res_shuffled %>%
  filter(padj < 0.1)

# Fewer (95 as opposed to 262) genes appear significant in this shuffled dataset,
# indicating that the 10% FDR threshold does not completely buffer analysis from
# false positives, since we're getting ~35% of the number of total results from
# the true data in our batch of known false positives



## Exercise 3
sex_res <- sex_res %>%
  mutate(color_condition = (padj < 0.1 & log2FoldChange > 1))
volcano <- ggplot(data = sex_res, aes(x = log2FoldChange, y = -log10(padj),color= color_condition ))+
         geom_point()

ggsave("~/qb25-answers/week8/volcano.png",plot = volcano)

library(tidyverse)
## Exercise 1
## Step 1.1 - Load/Filter Data
data_tsv <- read.table("read_matrix.tsv")
data <- as.matrix(data_tsv)

sds <- tibble(rowSds(data))

data_tsv <- data_tsv %>%
  mutate("Stdev" = sds)

data_tsv_ForFiltering <- data_tsv %>%
  arrange(by_group = desc(Stdev))


mostVariantGenes <- data_tsv_ForFiltering %>%
  head(500)

mostVariantGenes <- mostVariantGenes %>%
  select(-Stdev)

mostVariantGenes <- t(mostVariantGenes)

## Step 1.2 - Run PCA

filteredPCA <- prcomp(mostVariantGenes)

## Step 1.3 - Plot first two PCs and color based on Tissue and Replicate number

filteredPCAresults <- tibble(Sample = rownames(filteredPCA$x),Tissue = sub("_Rep.*", "", rownames(filteredPCA$x)), Replicate = sub(".*_Rep","",rownames(filteredPCA$x)),PC1 = filteredPCA$x[,1], PC2 = filteredPCA$x[,2])

faultyPCA <- ggplot(filteredPCAresults, aes(x = PC1,y = PC2, color = Tissue, shape = Replicate))+
  geom_point()
ggsave("~/qb25-answers/week7/PCAplotUncorrected.png", plot = faultyPCA)
## This reveals that LFC.Fe Replicate 3 and Fe Replicate 1 may have been swapped while labeling,
## I'm gonna manually replace them

# We store PC1 and PC2 values from the LFC.Fe_Rep3 sample in a placeholder tibble
temp_pcs <- filteredPCAresults %>%
  filter(Sample == "LFC.Fe_Rep3")
temp_pcs <- temp_pcs[,c("PC1","PC2")]

# We replace the LFC.Fe_Rep3 row PC1 and PC2 values with those from the Fe_Rep1
filteredPCAresults[filteredPCAresults$Sample == "LFC.Fe_Rep3", c("PC1", "PC2")] <- filteredPCAresults %>% 
  filter(Sample == "Fe_Rep1") %>% 
  select(PC1, PC2)

# the Fe_Rep3 row PC1 and PC2 is replaced with the LFC.Fe_Rep3 values that were stored in the placeholder (temp_pcs)
filteredPCAresults[filteredPCAresults$Sample == "Fe_Rep1", c("PC1", "PC2")] <- temp_pcs

## Now we can replot the PCA for PC1 and PC2 and see 7 clusters with three replicates from the same tissue in each cluster
correctedPCA <- ggplot(filteredPCAresults, aes(x = PC1,y = PC2, color = Tissue, shape = Replicate))+
  geom_point()

ggsave("~/qb25-answers/week7/PCAplotCorrected.png", plot = correctedPCA)

## To figure out what features are captured by each of the principal components, I'll use a heatmap like we did in the live coding exercise
heatmap(filteredPCA$rotation,Rowv=NA,Colv=NA)
# This didn't actually tell me too much about the features, since there are so many genes that are not sorted for enrichment in PC1, but I made this before I realized that the A-P axis was largely captured by PC1
## Scree Plot
pca_summary <- tibble(PC=seq(1,nrow(mostVariantGenes),1),sd=filteredPCA$sdev) %>%
  mutate(var=sd^2) %>%
  mutate(norm_var = var/sum(var))

screebar <- ggplot(pca_summary,aes(x=PC,y=norm_var))+
  geom_bar(stat = "identity")+
  labs(
    x = "Principal Component",
    y = "Variance Explained"
  )

ggsave("~/qb25-answers/week7/screeBarChart.png", plot = screebar)

## Exercise 2

# take the initial data and average over the replicates
combined <- data_tsv[,seq(1,21,3)]
combined <- combined + data_tsv[,seq(2,21,3)]
combined <- combined + data_tsv[,seq(3,21,3)]
combined <- combined / 3

# needs to be a matrix to use rowSds()
combined_matrix <- as.matrix(combined)
combined_stdev <- tibble(rowSds(combined_matrix))

# Add Stdev column to sort for highly variant genes
combined <- combined %>%
  mutate("Stdev" = combined_stdev)

combined_filtered <- combined %>%
  filter(combined$St >= 1)

set.seed(42)
kmeans_results <- kmeans(as.matrix(combined_filtered),centers = 12,nstart=100)
cluster_labels <- kmeans_results$cluster

combined_filtered <- combined_filtered %>%
  mutate("Cluster" = cluster_labels)

combined_filtered <- combined_filtered %>%
  arrange(by_group = Cluster)

sortedcluster_labels <- combined_filtered$Cluster

combined_filtered_noClusterCol <- combined_filtered %>%
  select(-Cluster)

combined_filtered_noClusterCol <- combined_filtered_noClusterCol %>%
  select(-Stdev)

png(file="heatmap.png")
heatmap(as.matrix(combined_filtered_noClusterCol), Rowv=NA, Colv=NA, RowSideColors=RColorBrewer::brewer.pal(12,"Paired")[sortedcluster_labels],ylab = "Gene")
dev.off()



## Exercise 3
cluster1 <- combined_filtered %>%
  filter(Cluster == 1)

cluster1 <- rownames(cluster1)

cluster2 <- combined_filtered %>%
  filter(Cluster == 2)

cluster2 <- rownames(cluster2)

cluster3 <- combined_filtered %>%
  filter(Cluster == 3)

cluster3 <- rownames(cluster3)

# Borrowed from Stack Overflow, I'm just trying to save time copy and pasting things into Panther
# This just outputs the gene names to text files that I can copy into the Panther interface
lapply(cluster1, write, "cluster1.txt", append=TRUE, ncolumns=1000)
lapply(cluster2, write, "cluster2.txt", append=TRUE, ncolumns=1000)
lapply(cluster3, write, "cluster3.txt", append=TRUE, ncolumns=1000)

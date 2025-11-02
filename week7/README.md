### Exercise 1.3
## Does everything look okay with the PCA plot?
# For the most part, yes, but there is one strange piece of data. It seems as though there are 7 clusters for 7 tissues, with each
# cluster containing the three replicates from one tissue. For the `LFC.Fe` and `Fe` tissues, however, we see two clusters with 2 samples of 1 tissue and 1 sample of the other. This is confusing, since we do see separation among these two clusters. It could be that the two samples were switched during the sequencing step, since the LFC.Fe and Fe tissues are near each other in the migut section. Additionally, it's the 3rd replicate of LFC.Fe and the first of Fe cells that may be swapped, and these appear right next to each other in the order of samples from the original data, which would make it more likely that a mislabeling event occurred.

## What feature explains the first principal component?
# The first principal component seems to be largely explained by the positioning of the tissues along the A-P axis. More negative values are anterior and more positive values posterior, with the only error being LFC.Fe and Fe being flipped. Those two are, however, right next to each other as appears in the samples.


### Exercise 3
## Cluster 1
# The enrichments make sense given that these samples came from the midguts of Drosophila. The enrichments in this cluster were primarily to do with metabolism (and the expression of genes involved in biosynthetic pathways) or transmembrane transport of various nutrients (amino acids, organic acids, etc.). These are all processes that seem essential for the Drosophila to uptake nutrients from their food and pass them to other parts of the body that can utilize these materials for synthesis of other macromolecules.

## Cluster 2
# These enrichments were different from Cluster 1 and also made sense for midgut tissues. The biological processes that these genes were implicated in were primarily immune responses and proteolysis (likely to do with breakdown of proteins secreted by symbionts/parasitic bacteria/viruses). This makes sense, since eating takes external materials and brings them inside the organism, along with any microbes that are along for the ride. As such, stomach tissues need to have some mechanism by which to prevent harmful pathogens from entering the body through the digestive tract.
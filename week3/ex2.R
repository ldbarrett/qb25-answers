library(tidyverse)

df <- read.table("~/qb25-answers/week3/AF.txt")

p1 <- ggplot(data = df, aes(x = V1)) +
  geom_histogram(bins = 11) +
  labs( # makes axis labels
    x = "Variant Frequency",
    y = "Number of Variants"
  )

ggsave("~/Desktop/VariantsHistogram.png", plot = p1, width = 5, height = 2.5)

## The histogram is skewed towards higher frequencies, and there's a second
## peak at AF = 1.0. I would say this is what I would expect, with more variants appearing
# more frequently, it appears as though the variants are not completely random (since it doesn't look Gaussian).

dfDepth <- read.table("~/qb25-answers/week3/DP.txt")

p2 <- ggplot(data = dfDepth, aes(x = V1)) +
  geom_histogram(bins = 21) +
  xlim(0,20) +
  labs(
    x = "Depth",
    y = "Number of Variants"
  )
  
ggsave("~/Desktop/DepthHistogram.png", plot = p2, width = 5, height = 2.5)
## Question 2.2
# This histogram peaks at a depth of ~5, and is skewed towards higher sequencing depth
# I think it looks as expected, I would expect more reads to be higher than the most abundant
# sequencing depth of ~5.

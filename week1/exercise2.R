library(tidyverse) # Load Tidyverse

header <- c( "chr", "start", "end", "count" )
dfA <- read_tsv("~/qb25-answers/week1/hg19-kc-count.bed", col_names=header ) #read in data from gene count file
dfB <- read_tsv("~/qb25-answers/week1/hg16-kc-count.bed", col_names=header ) #read in data from gene count file

df <- bind_rows(hg19 = dfA, hg16 = dfB, .id = "assembly")

ggplot(df,aes(x = start,y=count, color = assembly)) +
  geom_line()+
  facet_wrap(chr ~ .,scales = "free")

ggsave("exercise2.png")


# dfA_normalized <- dfA
# dfA_normalized$count <- dfA_normalized$count / sum(dfA_normalized$count)
# 
# dfB_normalized <- dfB
# dfB_normalized$count <- dfB_normalized$count / sum(dfB_normalized$count)
# 
# df_normalized <- bind_rows(hg19 = dfA_normalized, hg16 = dfB_normalized, .id = "assembly")
# 
# ggplot(df_normalized %>% filter(chr == "chr5"),aes(x = start,y=count, color = assembly)) +
#   geom_line()+
#   facet_wrap(chr ~ .,scales = "free")
# 
# dfAB_diff <- dfA
# dfAB_diff$count <- dfA_normalized$count - dfB_normalized$count
# 
# ggplot(dfAB_diff %>% filter(chr == "chr5"), aes(x = start, y= count)) +
#   geom_line()+
#   facet_wrap(chr ~ ., scales = "free")

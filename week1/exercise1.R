library(tidyverse) # Load Tidyverse

header <- c( "chr", "start", "end", "count" )
df_kc <- read_tsv("~/qb25-answers/week1/hg19-kc-count.bed", col_names=header ) #read in data from gene count file


  ggplot(df_kc,aes(x = start,y=count)) +
    geom_line()+
    facet_wrap(chr ~ .,scales = "free")
  
  ggsave( "exercise1.png" )
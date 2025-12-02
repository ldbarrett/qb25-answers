library(tidyverse)
coverage_array_3x <- read.table("3_coverageMap.txt")
coverage_array_10x <- read.table("10_coverageMap.txt")
coverage_array_30x <- read.table("30_coverageMap.txt")

zero_count_array_3x <- filter(coverage_array_3x, V1 == 0) %>%
  count()

zero_count_array_10x <- filter(coverage_array_10x, V1 == 0) %>%
  count()

zero_count_array_30x <- filter(coverage_array_30x, V1 == 0) %>%
  count()

poisson_3x <- read.table("3_poissonEstimates.txt")
poisson_10x <- read.table("10_poissonEstimates.txt")
poisson_30x <- read.table("30_poissonEstimates.txt")

normal_3x <- read.table("3_normalEstimates.txt")
normal_10x <- read.table("10_normalEstimates.txt")
normal_30x <- read.table("30_normalEstimates.txt")

coverage_array_3x$row_id <- 1:nrow(coverage_array_3x)
coverage_array_10x$row_id <- 1:nrow(coverage_array_10x)
coverage_array_30x$row_id <- 1:nrow(coverage_array_30x)

poisson_3x$row_id <- 0:(nrow(poisson_3x)-1)
poisson_10x$row_id <- 0:(nrow(poisson_10x)-1)
poisson_30x$row_id <- 0:(nrow(poisson_30x)-1)

normal_3x$row_id <- 0:(nrow(normal_3x)-1)
normal_10x$row_id <- 0:(nrow(normal_10x)-1)
normal_30x$row_id <- 0:(nrow(normal_30x)-1)


x3 <- ggplot(data = coverage_array_3x, aes(x=V1)) +
  geom_histogram(binwidth = 1)+
  geom_line(data=poisson_3x,aes(x=row_id,y=V1),color = "red")+
  geom_line(data=normal_3x,aes(x=row_id,y=V1),color="blue")+
  labs(
    x = "Number of Reads at a Base",
    y = "Frequency",
    title="Poisson in Red, Normal in Blue"
  )

x10 <- ggplot(data = coverage_array_10x, aes(x=V1)) +
  geom_histogram(binwidth = 1)+
  geom_line(data=poisson_10x,aes(x=row_id,y=V1),color = "red")+
  geom_line(data=normal_10x,aes(x=row_id,y=V1),color="blue")+
  labs(
    x = "Number of Reads at a Base",
    y = "Frequency",
    title="Poisson in Red, Normal in Blue"
    )

x30 <- ggplot(data = coverage_array_30x, aes(x=V1)) +
  geom_histogram(binwidth = 1)+
  geom_line(data=poisson_30x,aes(x=row_id,y=V1),color = "red")+
  geom_line(data=normal_30x,aes(x=row_id,y=V1),color="blue")+
  labs(
    x = "Number of Reads at a Base",
    y = "Frequency",
    title="Poisson in Red, Normal in Blue"
  )

ggsave("ex1_3x_cov.png",plot=x3)
ggsave("ex1_10x_cov.png",plot=x10)
ggsave("ex1_30x_cov.png",plot=x30)
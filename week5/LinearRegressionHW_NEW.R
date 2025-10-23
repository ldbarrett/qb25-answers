## Exercise 1
# Step 1.1 
library(tidyverse)
library(broom)

dnm_tibble <- read_csv("~/qb25-answers/week5/aau1043_dnm.csv")

# Step 1.2
dnm_tibblesorted <- arrange(dnm_tibble, Proband_id)
counts <- dnm_tibblesorted %>% 
  count(Proband_id, Phase_combined)

counts <- counts %>%
  filter(Phase_combined != "NA")

maternal_counts <- filter(counts, Phase_combined == "mother")
maternal_counts <- maternal_counts %>%
  rename("Maternal Counts" = n)

paternal_counts <- filter(counts, Phase_combined == "father")
paternal_counts <- paternal_counts %>%
  rename("Paternal Counts" = n)

# Step 1.3

parental_age <- read_csv("~/qb25-answers/week5/aau1043_parental_age.csv")

# Step 1.4

# This is a really crude way of doing this inner_join, because my counts function from
# Step 1.2 is a little wonky. That output has duplicate proband IDs (and twice as many rows as we want merged_data to have)
# This does two sequential inner_join() calls and I hard code a deletion of the 'Phase_combined' column of the counts function so that
# I can do both joins()

merged_data <- inner_join(parental_age,paternal_counts)
merged_data <- merged_data %>%
  select(!Phase_combined)
merged_data <- inner_join(merged_data, maternal_counts)
merged_data <- merged_data %>%
  select(!Phase_combined)

## Exercise 2
# Step 2.1
ggplot(data = merged_data,
       aes(x = Mother_age, y = `Maternal Counts`))+
  geom_point()+
  labs(
    x = "Maternal Age",
    y = "Number of DNMs"
  )

ggplot(data = merged_data, aes(x = Father_age, y = `Paternal Counts`))+
  geom_point()+
  labs(
    x = "Paternal Age",
    y = "Number of DNMs"
  )

# Step 2.2 and 2.3
maternal_model <- lm(data = merged_data, formula = `Maternal Counts` ~ 1 + Mother_age)
paternal_model <- lm(data = merged_data, formula = `Paternal Counts` ~ 1 + Father_age)

summary(maternal_model)
summary(paternal_model)

# Step 2.4
fiftyYearOldFather <- tibble(Phase_combined = "father", Father_age = 50.5)

fiftyYearOldFatherPrediction <- predict(paternal_model, newdata = fiftyYearOldFather)

# Step 2.5
ex2_c <- ggplot()+
  geom_histogram(data = merged_data,aes(x = `Paternal Counts`), color = "blue", alpha = 0.5)+
  geom_histogram(data = merged_data,aes(x = `Maternal Counts`), color = "red", alpha = 0.5)+
  labs(
    x = "Number of DNMs",
    y = "Number of Probands"
  )

ggsave("~/qb25-answers/week5/ex2_c.png", plot = ex2_c)

# Step 2.6
pairedT <- t.test(merged_data$`Maternal Counts`, merged_data$`Paternal Counts`, paired = TRUE)

manualT <- lm(data = merged_data, formula = `Maternal Counts` - `Paternal Counts` ~ 1)
summary(manualT)


# Step 3.1

library(stringr)
simpsons <- read_csv("~/qb25-answers/week5/simpsons_script_lines.csv")

sortedsimpsons <- simpsons %>%
  arrange(raw_text)

# ggplot(simpsons, aes(x = raw_text))+
#   geom_bar()+
#   labs(
#     x = "Alphabetized Order of Lines"
#   )

## How often does Homer say "Holy moly!" in this exact way?
holymoly <- simpsons %>%
  filter(raw_text == "Homer Simpson: Holy moly!")

# Very few occurrences in this dataset, but d'oh seems to correlate with initiating
# Or terminating a plot, since we see a depletion in the middle

doh <- simpsons %>%
  filter(grepl("d'oh",raw_text, ignore.case = TRUE))

dohdistribution <- ggplot(doh, aes(x = timestamp_in_ms/60000))+
  geom_histogram(binwidth = 3.67)+
  labs(
    x = "Time (ms)",
    y = "Line Occurrence"
  )

ggsave("~/qb25-answers/week5/dohdistribution.png", plot = dohdistribution)


## Number of Lisa/Marge/Other Characters lines per episode from 2010-2016
lisa <- simpsons %>%
  filter(raw_character_text == "Lisa Simpson")

ggplot(filter(simpsons, raw_character_text == "Lisa Simpson"), aes(x = episode_id))+
  geom_histogram(binwidth = 1)+
  labs(
    x = "Episode Number",
    y = "Lines Spoken by Lisa"
  )


marge_hist <- ggplot(filter(simpsons, raw_character_text == "Marge Simpson"), aes(x = episode_id))+
  geom_histogram(binwidth = 1)+
  labs(
    x = "Episode Number",
    y = "Lines Spoken by Lisa"
  )


ggplot(filter(simpsons, raw_character_text == "Homer Simpson"), aes(x = episode_id))+
  geom_histogram(binwidth = 1)+
  labs(
    x = "Episode Number",
    y = "Lines Spoken by Lisa"
  )

bart_hist <- ggplot(filter(simpsons, raw_character_text == "Bart Simpson"), aes(x = episode_id))+
  geom_histogram(binwidth = 1)+
  labs(
    x = "Episode Number",
    y = "Lines Spoken by Lisa"
  )

lisa_spokenlines <- ggplot_build(lisa_hist)$data[[1]]
marge_spokenlines <- ggplot_build(marge_hist)$data[[1]]
homer_spokenlines <- ggplot_build(homer_hist)$data[[1]]
bart_spokenlines <- ggplot_build(bart_hist)$data[[1]]

lisa_fit <- lm(data = lisa_spokenlines, formula = y ~ 1 + x)
print("Lisa Coefficients")
summary(lisa_fit)

marge_fit <- lm(data = marge_spokenlines, formula = y ~ 1 + x)
print("Marge Coefficients")
summary(marge_fit)

homer_fit <- lm(data = homer_spokenlines, formula = y ~ 1 + x)
print("Homer Coefficients")
summary(homer_fit)

bart_fit <- lm(data = bart_spokenlines, formula = y ~ 1 + x)
print("Bart Coefficients")
summary(bart_fit)


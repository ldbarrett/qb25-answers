### Step 2.2
## 1. What is the size of this relationship?
# The 'size' of the relationship is 0.37757. In plain language, this means that for every year a woman ages, the predicted number
# of DNM mutations in her offspring would increase by ~0.4. This aligns with my plot. If, by eye, I try to fit a line to the data,
# it would increase by a little less than 5 DNMs going from a 20 year old mother to a 30 year old mother, which aligns with a slope 
# less than 0.5

## 2. Is the relationship significant?
# The relationship is significant, the p-value for this regression is 2e-16. This means, in plain language, that the slope of this
# regression is so much greater than if there were no correlation in this data that the probability that such a relationship would
# emerge if there were no correlation is 1 in 2*10^16 (in other words, astronomically small)

### Step 2.3
## 1. What is the size of this relationship?
# 1.35384. As above, we expect that every time a father ages 1 year, the predicted number of DNMs in the offspring increases by 1.35.
## 2. Is the relationship significant?
# The relationship is 


### Step 2.4
## Predict the number of DNMs in a proband from a 50.5 year old Father
# I used the predict() function on the DNM_count linear regression that I stored in a paternal_model variable, and I generated a new tibble with the attributes of our desired Father for the question
# My code looks like:
```
paternal_model <- lm(data = counts_and_ages %>% filter(Phase_combined == "father"), formula = n ~ 1 + Father_age)
fiftyYearOldFather <- tibble(Phase_combined = "father", Father_age = 50.5)
fiftyYearOldFatherPrediction <- predict(paternal_model, newdata = fiftyYearOldFather)

```
### Step 2.5
# The distribution of Paternal DNMs is centered at a higher value than Maternal DNMs, in line with our findings on the 'size' of each linear relationship earlier.

### Step 2.6
# The average difference in DNM counts from maternal to paternal is -39.23, and I input Maternal Counts before Paternal Counts as my two columns in the t.test() function. This means that, for each proband, there is on average 40 more DNMs from the father than the mother. This does match my plot of histograms. Going roughly from the peaks, they are centered ~40 DNM counts apart from each other, with the Paternal DNMs having a higher average DNM count
# The relationship is significant, the p-value is 2.2*10^-16. In plain language, this means the probability that this difference of DNM counts from paternal and maternal origin is not due to intrinsic differences in spermatogenesis and oogenisis, but rather randomly arose, is 1 in 2.2 * 10^16 (extremely low).
# For the manual T-test, the intercept is the same as the mean difference resulting from the paired t test function (above). I interpret this as the mean difference between Maternal and Paternal DNM counts. We're fitting a horizontal line to a dataset of `Maternal DNM count - Paternal DNM Count`, so if there is a significant difference between the two distributions we'll find the intercept would be closer to zero.


### Step 3.1
# I chose the "Donuts, Data, and D'oh - A Deep Dive into The Simpsons" dataset, and focused on the `simpsons_script_lines.csv` file within that repository

### Step 3.2
# The first thing I explored in this dataset was the use of Homer Simpson's iconic "D'oh!" line. This dataset is a subset of episodes from 2010-2016 with each individual line that appears on screen (via closed captions) parsed and given a unique identifier. Episode identifiers were given as well, along with which character uttered the line. Using the `grepl` command, I filtered the dataset for lines in which "D'oh!" (case insensitive) is uttered, though not necessarily by Homer himself. In doing so, I only got 8 items from the dataset (which I confirmed by Cmd+F through the .csv on excel to rule out any changes in spelling/punctuation—just a sparse dataset!). Another column of the dataset included the time in which the line was uttered during the episode in units of milliseconds. The first plot I generated, `dohdistribution.png` is a histogram of the times in the episode in which each of the "D'ohs" sampled was uttered. I binned the ~22 minute episodes into 6 bins (assuming a 3-act structure of each episode, with 2 bins for each act) and found a roughly bimodal distribution. From this, I propose that the use of "D'oh" is primarily to mark the beginning or ending of an episode's plot, since we are more likely to hear it at the beginning or ending of the episode. I would like to explore this with a more comprehensive dataset if possible.

# To inspect features of the dataset with larger samples, I decided to investigate the distribution of each main character's spoken lines over time from 2010-2016. I generated histograms of the number of lines spoken by Lisa, Marge, Homer, and Bart per episode (ordered chronologically on the x axis) with each bin representing one episode. From this, I could see that each character has busy and quiet episodes, but I wondered whether I could explore trends in their significance over time using linear regression. I was able to extract the x and y values of the dataset using `lisa_spokenlines <- ggplot_build(lisa_hist)$data[[1]]`, and then performed linear regressions using this data.

### Step 3.3
# After inspecting the histograms of lines spoken per episode for the four main characters, I hypothesized that the number of lines spoken by Lisa, Homer, and Marge over time would not change (slope ~ 0) and would decrease for Bart.
# Lisa fit: Slope - -0.06061; Intercept - 50.16194; P-value - 0.1439
# Marge fit: Slope - 0.05572; Intercept - -5.16747; P-value - 0.1568
# Homer fit: Slope - 0.06052; Intercept - 15.93; P-value - 0.3111
# Bart fit: Slope - -0.06137; Intercept - 52.73467; P-value - 0.1123

# Perhaps predictably, none of these relationships were found to be significant. Still, we may interpret some things about the coefficients. For example, I was initially surprised by the fact that the fitted intercept for Homer was lower than that of Lisa, despite it seeming like Homer spoke far more lines than Lisa, both in total and on a per-episode basis. On closer inspection, however, the Homer dataset has better coverage across the lower frequencies of spoken lines per episode (in the 15-20 lines range), while a greater fraction of these episodes feature Lisa speaking <5 or >30 lines. Even though Homer appears to have spoken more overall, it may be that the regression gives Lisa a higher intercept to try and split the difference between high and low values, while in Homer's case the best fit yields the majority of low-line episodes.

# Additionally, the coefficients for Bart's and Lisa's regressions were quite similiar, despite my visual inspection suggesting that Bart's frequency of spoken lines decreased over time. Looking back at the histograms, I believe that this owed to a visible down-sloping of his spoken lines in the last 25 or so episodes (despite a transient peak at ~ep560), which misled me to believe such a pattern existed over the entire set of episodes in this dataset.


# Packages:
library(readr)
library(haven)
library(car)
library(forcats)
library(tidyverse)

# CSV URL to the data
csv_dir <- "https://raw.githubusercontent.com/cimentadaj/tidyverse_seminars/master/first_seminar/data/pisa2015.csv"

# Read data
pisa_2015 <- read_csv(csv_dir)

# 1.

summary_pisa <-
  pisa_2015 %>%
  rename(country = CNT,
         region = Region,
         school_id = CNTSCHID,
         gender = ST004D01T,
         books_in_hh = ST013Q01TA,
         math_score = PV1MATH) %>%
  select(region, country, school_id, gender, books_in_hh, math_score) %>%
  mutate(gender = car::recode(gender, "1 = 'Female'; 2 = 'Male'"))

# Check the overall math mean
summary_pisa %>%
  summarise(mean(math_score, na.rm = T))

# Check the between country mean and arrange to see the best performer in math
summary_pisa %>%
  group_by(country) %>%
  summarise(avg_country = mean(math_score, na.rm = T)) %>%
  arrange(-avg_country) # Also try with - sign

# Repeat the same as before but group by gender
summary_pisa %>%
  group_by(country, gender) %>%
  summarise(avg_country = mean(math_score, na.rm = T)) %>%
  ggplot(aes(x = reorder(country, avg_country),
             y = avg_country,
             colour = gender)) +
  geom_point(alpha = 0.6) +
  coord_flip()


# Finally, let's check which countries have the biggest between school
# variance in math test score and visualize them.

summary_pisa %>%
  group_by(region, country, school_id) %>%
  summarise(avg_schools = mean(math_score, na.rm = T)) %>%
  group_by(region, country) %>%
  summarise(sd_country = sd(avg_schools, na.rm = T)) %>%
  filter(!is.na(region)) %>%
  ggplot(aes(x = fct_reorder2(country, region, sd_country, .desc = F),
             y = sd_country,
             fill = region)) +
  geom_col() +
  coord_flip()

# Answers

library(tidyverse)

#1

population %>%
  spread(year, population) %>%
  group_by(country) %>%
  mutate(diff = `2013` - `1995`) %>%
  ungroup() %>%
  sample_n(35) %>%
  filter(complete.cases(.)) %>%
  ggplot(aes(reorder(country, diff), diff)) +
  geom_point() +
  coord_flip()

#2 
population %>%
  separate(year, c("century", "year"), sep = 2) %>%
  spread(year, population) %>%
  mutate(twentyfirst = `13` - `00`,
         twenty = `99` - `95`,
         both = pmax(twentyfirst, twenty, na.rm = T)) %>%
  select(country, century, both) %>%
  filter(country %in% sample(unique(country), 30),
         complete.cases(.)) %>%
  ggplot(aes(reorder(country, both), both, colour = century)) +
  geom_point(alpha = 0.7) +
  coord_flip()

#3
population %>%
  spread(country, population) %>%
  select(year, Spain, France) %>%
  mutate(france_diff = c(NA, diff(France)) / lag(France),
         spain_diff = c(NA, diff(Spain)) / lag(Spain)) %>%
  gather(change, percentage, france_diff, spain_diff) %>%
  select(-Spain, -France) %>%
  ggplot(aes(year, percentage, group = change, colour = change)) +
  geom_line()
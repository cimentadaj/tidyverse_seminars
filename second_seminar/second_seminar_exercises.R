# Start of exercises for second seminar
# Author: Jorge Cimentada
# Session: Second tidyverse seminars

# Briefly, let's recap the main tools you'll use.
install.packages("tidyverse", dependencies = T)

# Packages:
library(readr) # Reading csv
library(haven) # Reading STATA, SPSS or SAS
library(tidyverse)

# Usual ggplot2 structure
ggplot(data = <DATA>, aes(<MAPPINGS>)) + 
  <GEOM_FUNCTION>()

# Most common geoms:
geom_point()
geom_bar()
geom_histogram()
geom_boxplot()
geom_density()
geom_line()
geom_smooth()

# Most common aesthetics:
alpha
colour
fill
group
shape
size
stroke

# How to connect expresions:
%>%
  
# Common dplyr verbs for data manipulation:
mutate()
select()
filter()
arrange()
group_by()
summarise()
rename()

# Common dplyr verbs for relational databases:
left_join()
right_join()
inner_join()
full_join()

# Common tidyr verbs for data munging:
gather()
spread()
separate()
unite()

# Reading data:
read_csv() # CSV, comma delimited
read_stata() # Stata file: supports versions 8-14.
read_spss() # SPSS (.sav) files
read_sas() # SAS files
read_excel() # Read .xls or .xlsx


# 1. Let's use the population dataset which contains the population of several countries for some years.
# Have a look:
population

# Using spread, turn the year column into wide format. Extend the pipeline and group_by country
# and create a column with the difference between the highest and lowest year called diff.

# Using select, select the country and diff variables and pipe that to arrange to see the countries
# with the biggest population growth.

# EXTRA: sample some random countries with the function sample_n (?sample_n) and use ggplot
# to visualize the results. Use the geom you find appropriate.

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


# 2. Let's calculate which century (21st of 20th) had a greater population growth for some countries.
# First, pipe the population tibble to separate and separate the year variable into two variables
# called century and year. Divide the variable so that the `19` and `20` of 1999 and 2000 come in
# the century variable and the `99` and `00` come in the year variable.

# Pipe that to the spread function and spread the year and population variables into wide format.
# Create a variable called twentyfirst where you subtract the highest from the lowest year in the
# twentyfirst century and another called twenty where you repeat the same. Finally,
# create a last variable called both where you use pmax to get the highest of both columns.
# Remember to remove NA's!

# Finish off by selecting country, century and the both variable, sample some random countries
# and visualize with ggplot2 with your prefered geom.

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



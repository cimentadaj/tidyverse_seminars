# Start of exercises for first seminar
# Author: Jorge Cimentada
# Session: First tidyverse seminars

# Briefly, let's recap the main tools you'll use.

# Packages:
library(readr) # Reading csv
library(haven) # Reading STATA, SPSS or SAS
library(car) # For recoding
library(forcats) # For factor variables
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

# Common dplyr verbs:
mutate()
select()
filter()
arrange()
group_by()
summarise()
rename()

# Reading data:
read_csv() # CSV, comma delimited
read_stata() # Stata file: supports versions 8-14.
read_spss() # SPSS (.sav) files
read_sas() # SAS files
read_excel() # Read .xls or .xlsx

# 1. Reading the data

# URL's to the data
csv_dir <- "https://raw.githubusercontent.com/cimentadaj/tidyverse_seminars/master/first_seminar/data/pisa2015.csv"
spss_dir <- "https://raw.githubusercontent.com/cimentadaj/tidyverse_seminars/master/first_seminar/data/pisa2015.csv"

# Depending on your usual statistical software, read the corresponding directory
# with the appropriate function by placing the *_dir object inside the function
# and assign the dataset the name pisa_2015

read_csv()
read_spss()

# 2. Cleaning the data

# We want to rename some variables, delete others and do some recoding.
# Read first and then complete the exercises below!!

# Using the pipe, pipe the pisa_2015 into the rename function and rename these
# variables:

# country = CNT
# region = Region
# school_id = CNTSCHID
# gender = ST004D01T
# books_in_hh = ST013Q01TA
# math_score = PV1MATH

# Pipe the result of rename to the select function and select the same variables
# you just renamed.

# Finally, pipe the result of select to the mutate function and create a new gender
# variable called gender that includes this code as the new variable:
# car::recode(gender, "1 = 'Female'; 2 = 'Male'")

# Below is an empty skeleton of what you need to do:

summary_pisa <-
  data %>%
  rename variables %>%
  select variables %>%
  create the new gender variable with the recode from above

# 3. Exploratory Data Analysis (EDA)

# In the previous expression we saved our new summarized data as 'summary_pisa'.
# Let's have a look:
summary_pisa

# Now we want to calculate the overall math mean.
# You can do that by piping the summary_pisa data into the summarise
# function and create a new variable called avg_math which uses the
# mean() function over the 'math_score' variable to get the overall mean.
# Don't forget to include na.rm = T to exclude missings!

Your answer

# Let's do similarly as before but calculate the average for each country. 
# That way we can see which are the top performers and which are the worst.
# You can do that by piping 'summary_pisa' to the group_by() function and
# grouping by the variable 'country'. Then repeat the summarise command from
# the previous exercises.

Your answer

# Wait! Before finishing, we'd want to see the worst and best performers.
# Try piping the previous expression to the arrange() function and sorting
# by the variable 'avg_country'. When you do, experiment by placing a minus
# sign infront of the 'avg_country' variable.

########################################################################

# We're interested in the gender gap in math for each country.
# With the tidyverse this is very easy. Copy the previous expression below
# this paragraph. How would you do it? We simply need to estimate the
# score for males and females (variable gender).

# Think about it this way: right now we're grouping by country..
# and we want to get the score for each country by Male and Female as well.

Your answer

# We got the results! But visualizing is the best way of understanding
# patterns. Copy the previous expression below this text.

# Pipe the whole expression to the ggplot function. Inside
# ggplot specify the 'aes()' option and specify country as
# the X axis and avg_country as the Y axis. Also, don't
# forget to 'colour' with the gender variable. Finally,
# which plot would you like to see? geom_col()? geom_point()? Experiment

Your answer

# Whichever you choose, add alpha = 0.06 inside the geom_*() function
# and add '+ coord_flip()' outside the geom_*() function
# to make the plot horizontal and see the country names.

# Ahh!! Looks disorganized. Try to 'reorder()' the country variable by
# the avg_country variable in the X argument from the 'aes()' option.

########################################################################

# Finally, let's check which countries have the biggest between school
# variance in math test score and visualize it.

# Let's start by piping the summary_pisa data and group by region, country and
# school_id.

Your answer

# Copy that and pipe it to the summarise function. Calculate the mean
# math_score and call that variable avg_schools. Remember to exclude missings!

Your answer

# Alright, now we have the mean math score for each school within each country
# and within each region. We now want to calculate the country standard deviation
# of these averages to estimates the between school variability in math.

# How would we do this? Well, we can regroup this NEW data frame. Try
# copying the previous expresion, piping that to 'group_by()' and group region
# and country again. Before finishing, using the summarise function
# create a new variable called sd_country which calculates the 'sd()'
# of 'avg_schools'. Remember to exclude missings!

Your answer

########################################################################

# Copy the previous expression. Let's finish by filtering out the rows
# that have a missing in the 'region' variable. Piping the expression
# to the filter() function, include !is.na(region) inside filter.

Your answer

# We have everything ready to graph!

# Copy the previous expression and pipe that to ggplot(). Inside the
# aes() option specify the X axis as: 
# fct_reorder2(country, region, sd_country, .desc = F)
# This simply means: reorder country by region and sd_country in ascending order
# Specify Y to be sd_country and use the fill option with 'region'.
# Add the geom_col() + coord_flip() to that.

Your answer

# That's pretty neat! Looks like Malta is extremely unequal in terms of math
# followed by Singapore. No clear-cut relationship between regions, though.

# Start of exercises for second seminar
# Author: Jorge Cimentada
# Session: Second tidyverse seminars

# Briefly, let's recap the main tools you'll use.
install.packages("tidyverse", dependencies = T)

# Packages:
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


# 1.
# Let's use the population dataset which contains the population of several countries for some years.
# Have a look:
population

# Using spread, turn the year column into wide format. Extend the pipeline and group_by country
# and create a column with the difference between the highest and lowest year called diff.

# Using select, select the country and diff variables and pipe that to arrange to see the countries
# with the biggest population growth.

# EXTRA: sample some random countries with the function sample_n (?sample_n) and use ggplot
# to visualize the results. Use the geom you find appropriate.


# 2.
# Let's calculate which century (21st of 20th) had a greater population growth for some countries.
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


# 3.
# In this last exercise we'll compare the rate of population growth for two countries of your choice.
# First, spread the country column into rows with the population variable to fill in the columns.
# Select the year column and two countries of your choice.
# Next we want to calculate the percentage in population for each year. For that we'll use
# the code 'c(NA, diff(country)) / lag(country)'. Using mutate, create two new columns
# containing each country's percentage change with the excerpt from above.

# In my case, I have something like this:

# A tibble: 19 × 5
#      year    Spain   France france_diff  spain_diff
#     <int>    <int>    <int>       <dbl>       <dbl>
# 1   1995 39420568 58008958          NA          NA
# 2   1996 39513721 58216225 0.003573017 0.002363056
# 3   1997 39603778 58418324 0.003471524 0.002279132
# 4   1998 39729942 58635564 0.003718696 0.003185656
# 5   1999 39944692 58894671 0.004418939 0.005405243

# Now let's gather that data so that france_diff and spain_diff become
# stacked columns. Once you stack them, select only year and your two new columns. Finish by
# visualizing your results in ggplot2. Put your year column in the X axis and the percentage column
# in the Y axis. Use the group and colour option to specify the stacked column with the categories
# and add geom_line(). Voila!
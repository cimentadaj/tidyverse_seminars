###############
# Author: Jorge Cimentada
# Time: Fri Mar  3 10:09:12 2017
# Project: Fourth tidyverse seminar
###############

###############
# Author: Jorge Cimentada
# Time: Fri Mar  3 10:09:00 2017
# Project: Fourth tidyverse seminar
###############

# For this exercise, these are some of the things you'll be using:

library(tidyverse) # For all tidyverse packages
library(broom) # For the glance function

# For performing loops
map(.x, .f, ...)
map_lgl(.x, .f, ...)
map_chr(.x, .f, ...)
map_int(.x, .f, ...)
map_dbl(.x, .f, ...)
map_df(.x, .f, ..., .id = NULL)

# For creating functions:

your_function_name <- function(x, y, z, etc..) {
  
  # Body of the function
  
  return() # If you want to return something that is not the last line
  
  # Body of the function
}

# Remember the:
# %>%

#1. Read the 'bad_driver.csv' data with this URL and the read_csv() function. Assign the data
# the name bad_drivers.

url <- "https://raw.githubusercontent.com/cimentadaj/tidyverse_seminars/master/third_seminar/data/bad_drivers.csv"
bad_drivers <- read_csv(url)

#2. Really quickly, to get familiarized with the data, we want to calculate the mean of each
# numeric column. We can do that by specify bad_drivers as the first argument and mean as the function.
# Two caveats: not all variables are numeric and I want the result to be a numeric vector instead
# of a list. 

# Note: your result shouldn't produce any warnings

map_dbl(bad_drivers[-1], mean)

# 3. 
states <- setNames(state.region, state.name)
bad_drivers$region <- states[bad_drivers$state]
bad_drivers$state <- as.factor(bad_drivers$state)

# I've introduced the region column in the previous line (+ turned state into a factor).
# By default, this columns is created as a factor and we don't want that. Aside from this,
# there might be other variables which are factors, and we would like for them to be characters.

# Test whether bad_drivers$region is a factor by using is.factor()

# Try coercing bad_drivers$region into a character with as.character()

# 4. Create a function valled fac_to_char that coerces a factor to a character, if the input
# is a factor. If the input is not a factor, return the same input unchanged.

# To identify if a vector is a factor use `is.factor()`
# To coerce anything to a character vector use `as.character()`

# In this exercise you'll need to use if statements, so read this brush up:

if (this condition is TRUE) {
  execute this
} else {
  execuse this
}

fac_to_character <- function(x) {
  if (is.factor(x)) {
    as.character(x)
  } else {
    x
  }
}

# Test your function with this code:
is.character(fac_to_character(bad_drivers$state))
is.character(fac_to_character(bad_drivers$region))

# If both expressions return TRUE, the you got it right! Congrats!

# 5.
# Using map_df (which loops over something and returns a data frame (df)), loop over each bad_drivers
# column and apply your newly created function fac_to_character. Save the results to bad_drivers_upd.
# The output should be the same data frame but with no factor variables.

bad_drivers_upd <- map_df(bad_drivers, fac_to_character)

# 6.
# Quickly, how can we programatically check how many factors we have in our data frame?
# With map_lgl (which loops over something and returns a vector of logical values), loop
# over bad_drivers_upd applying the function is.factor. Before running the code,
# can you predict the length and exact contents of our result? This should help you
# understand how loops work.

map_lgl(bad_drivers_upd, is.factor)

# You could even wrap your previous expression with table() to get a table of T's and F's. Try it:
table(map_lgl(bad_drivers_upd, is.factor))

# 7. We want to do a separate regression for of each of the regions to check whether the
# num_drivers (Number of drivers in fata collisions per billion miles) is explained by
# perc_speeding and perc_alcohol.

# Let's start by nesting the data into list-columns. Pipe bad_drivers_upd to group_by region.
# Then use the nest function to nest region data sets into list-value pairs. Look at the ?nest
# examples to understand how it works.


# If you looked at the previous result, the data frame has a row with missing values. We want
# to exclude those, but we want to do it in an automated way, in case we use another data frame
# and not only this one. 

# 8.
# I want you to create a function called is_na_fun() that accepts one argument. Using `stopifnot()`
# function check that the data frame is a data frame (is.data.frame()).

# In the body of the function, using is.na(), which() and the `-` sign, delete
# the rows that have any NA's. This might be hard, but think of it like this:
# Take df, open brackets, which are NA's in df? deleted it and keep al columns.

is_na_fun <- function(df) {
  stopifnot(is.data.frame(df))
  
  df[-which(is.na(df)), ]
}

# 9.
# Using the previous pipeline, after nest(), add your own `is_na_fun()` to the pipeline
# See how it works?! You can create your own functions and customize the pipeline.
# Now pipe that to mutate to create a new column called `lm_model`. This column
# will use `map()` to loop over the data column (which is a list) and will run
# a linear regression using this command `lm(num_drivers ~ perc_speeding + perc_alcohol, data = your_data)`.
# Remember, you'll need to create an `anonymous function` and pass your argument to the data argument!

# You should have something similar to this (piped to the previous expression):

mutate(var_name = map(your_column, function() lm(num_drivers ~ perc_speeding + perc_alcohol, data = your_data)))

# BEFORE DOING THIS, try to predict what the outcome will be based on the previous line.


# Once you have it done, I want you to wrap the `lm` expression in a function called `glance()` which
# will give you the diagnostics of the model, such as R2, Pvals, and so on..


# To wrap it up, pipe the previous pipeline to unnest() and unnest the lm_model function.
# Pipe that to select and choose only variables region and r.squared.


# Awesome! That was a real data analysis workflow there.

bad_drivers_upd %>%
  group_by(region) %>%
  nest() %>%
  is_na_fun() %>%
  mutate(lm_model = map(data, function(our_data) glance(lm(num_drivers ~ perc_speeding + perc_alcohol, data = our_data)))) %>%
  unnest(lm_model) %>%
  select(region, r.squared)
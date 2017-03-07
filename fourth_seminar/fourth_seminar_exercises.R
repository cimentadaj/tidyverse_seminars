###############
# Author: Jorge Cimentada
# Time: Fri Mar  3 10:09:00 2017
# Project: Fourth tidyverse seminar
###############

# For this exercise, these are some of the things you'll be using:

library(tidyverse) # For all tidyverse packages

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
bad_drivers <- read_csv(url, )

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

# You could even wrap your previous expression with table to get a table of T's and F's. Try it:

table(map_lgl(bad_drivers_upd, is.factor))


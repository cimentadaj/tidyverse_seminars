# Start of exercises for first seminar

# Briefly, let's recap the main tools you'll use.

# Packages:
library(fivethirtyeight)
library(readr)
library(readxl)
library(haven)
library(car)
library(tidyverse)


# Usual ggplot2 structure
ggplot(data = <DATA>) + 
  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

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

# Start of exercises:

pisa_2015 <- read_spss("/Users/cimentadaj/Downloads/PISA/CY6_MS_CMB_STU_QQQ.sav")
pisa <- pisa_2015

# Function recevies a variable with an attribute label
# and recodes the variable to availabe lables
# Returns the same variable with new codings
variable_labeller <- function(variable) {
  
  if (!is.null(attr(variable, "labels"))) {
    
    var_attr <- attributes(variable)
    label_changer <- reverse_name(attr(variable, "labels"))
    variable <- label_changer[variable]
    
    attributes(variable) <- var_attr
    variable
  }
}

pisa <-
  pisa %>%
  mutate(Region = countrycode(CNT, "iso3c", "continent"),
         CNT = as.character(variable_labeller(CNT))) %>%
  sample_n(10000)



write_csv(pisa, "./data/pisa2015.csv")

# bad_vars <- map_lgl(pisa, function(x) is.labelled(x) && is_double(x))
# pisa_2 <- pisa
# pisa_2[bad_vars] <- map_df(pisa_2[bad_vars], is.integer)
# 
# map_lgl(pisa_2, function(variable) {
#   any(map_lgl(names(attr(pisa_2$STRATUM, "labels")), function(labels) nchar(labels) > 31))
# })

# write_dta(pisa_2, "./data/pisa2015.dta")
# write_sav(pisa, "./data/pisa2015.sav")

# CSV URL to the data
csv_dir <- "https://raw.githubusercontent.com/cimentadaj/tidyverse_seminars/master/first_seminar/data/pisa2015.csv"

pisa_2015 <- read_csv(csv_dir)

# Avoid the dplyr::select problem

# Let's figure out which gender has more books in the household
summary_pisa <-
  pisa_2015 %>%
  rename(country = CNT,
         school_id = CNTSCHID,
         gender = ST004D01T,
         books_in_hh = ST013Q01TA,
         math_score = PV1MATH) %>%
  dplyr::select(country, school_id, gender, books_in_hh, math_score) %>%
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
  arrange(-avg_country)  %>%
  ggplot(aes(x = reorder(country, avg_country),
             y = avg_country,
             colour = gender)) +
  geom_point(alpha = 0.6) +
  coord_flip()

# Let's pick a country and check the distribution of books in the household
summary_pisa %>%
  filter(country == "Spain") %>%
  ggplot(aes(country, books_in_hh)) +
  geom_boxplot()

# Group by gender now:
summary_pisa %>%
  filter(country == "Spain") %>%
  ggplot(aes(gender, books_in_hh)) +
  geom_boxplot()

# Step back and choose another country
summary_pisa %>%
  filter(country %in% c("Spain", "United States")) %>%
  ggplot(aes(gender, books_in_hh)) +
  geom_boxplot() +
  facet_wrap(~ country)

# Finally, let's check which countries have the biggest between school
# variance in math test score and visualize them.

summary_pisa %>%
  group_by(country, school_id) %>%
  summarise(avg_math = mean(math_score, na.rm = T)) %>%
  group_by(country) %>%
  summarise(sd_country = sd(avg_math, na.rm = T))
  



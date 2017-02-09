# Start of exercises for first seminar

# Briefly, let's recap the main tools you'll use.

# Packages:
library(tidyverse)
library(fivethirtyeight)
library(readr)
library(readxl)
library(haven)

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
pisa_2015 <- pisa
pisa <- pisa_2015[sample(nrow(pisa_2015), 10000), ]

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

variable_labeller(pisa$CNT)

pisa <-
  pisa %>%
  mutate(CNT = as.character(variable_labeller(pisa$CNT)))



write_csv(pisa, "./data/pisa2015.csv")

# bad_vars <- map_lgl(pisa, function(x) is.labelled(x) && is_double(x))
# pisa_2 <- pisa
# pisa_2[bad_vars] <- map_df(pisa_2[bad_vars], is.integer)
# 
# map_lgl(pisa_2, function(variable) {
#   any(map_lgl(names(attr(pisa_2$STRATUM, "labels")), function(labels) nchar(labels) > 31))
# })

write_dta(pisa_2, "./data/pisa2015.dta")
write_sav(pisa, "./data/pisa2015.sav")

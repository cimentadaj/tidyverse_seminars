###############
# Author: Jorge Cimentada
# Time: Tue Feb 28 18:24:55 2017
# Project: Third tidyverse seminar
###############

# 1st.
# Open ggplot2 with the library function.

# Make this plot work.
library(ggplot2)

ggplot(mtcars, aes(cyl, log(mpg))) +
  geom_point(alpha = 0.7) +
  geom_jitter() +
  scale_x_continuous(name = "Cylinders",
                     breaks = c(4, 6, 8)) +
  scale_y_continuous("Miles per gallon")

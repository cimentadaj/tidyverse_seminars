###############
# Author: Jorge Cimentada
# Time: Tue Feb 28 18:23:03 2017
# Project: Third tidyverse seminar
###############

# 1st.
# Open ggplot2 with the library function.
library(ggplot2)

# Make this plot work.
ggplot(mtcars, aes(cyl, log(mpg))) +
  geom_point(alpha = 0.5) +
  geom_jitter() +
  scale_x_continuous(name = "Cylinders",
                     breaks = c(4, 6, 8)) +
  scale_y_continuous("Miles per gallon")

# Make a barplot with the `cyl` variable from mtcars and make the fill of each barplot unique
# for each `cyl`. There's a catch: the `cyl` variable doesn't have the right class ;)

ggplot(mtcars, aes(x = as.factor(cyl), fill = as.factor(cyl))) +
  geom_bar()

# 3rd.
# Reproduce to this graph to the smallest detail:

ggplot(mtcars, aes(mpg, disp, colour = as.factor(cyl))) +
  geom_point() +
  geom_smooth() +
  facet_wrap(~ cyl) +
  ggtitle("Relationship between miles per gallon and displacement for different cylinders") +
  scale_colour_discrete(guide = F)

# 4th
# Let's create a layered plot.

# Pipe mtcars to ggplot and specify `mpg` and `disp` as the x and y aesthetics.
# Add a geom_point() to create a scatterplot with the relationship.
# Add a geom_smooth() to get the wiggly prediction line.


# At this point you have a nice scatterplot. We want to overlay a density plot with the
# distribution of mpg over this plot. We can do that by overlaying a geom_density plot.
# Add geom_density and inside define the aes() call with mpg as the x variable and
# the ggplot created variable ..density.. as the y variable. Before finishing,
# incluse inhertir.aes = F outside aes but inside geom_density to let ggplot know not to use
# the global variables.

# Note that there is a density plot but we can't really see the height because the y variable of
# density is not scaled to be in hundreds like the 'disp' variable. Simply multiply ..density.. by
# 1000 and you should have it scaled

# Finally, add a facet_wrap call with ~ am inside to calculate this exact same thing for different
# different `am` subsets.

# Finish by adding a title with ggtitle()

# Voila

ggplot(mtcars, aes(mpg, disp)) +
  geom_point() +
  geom_smooth() +
  geom_density(aes(x = mpg, y = ..density.. * 1000), inherit.aes = F) +
  facet_wrap(~ am) +
  ggtitle("Relationship between miles per gallon and displacement for different cylinders")

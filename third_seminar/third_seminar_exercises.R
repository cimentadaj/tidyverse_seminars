###############
# Author: Jorge Cimentada
# Time: Tue Feb 28 18:24:55 2017
# Project: Third tidyverse seminar
###############

# 1st.
# Open ggplot2 with the library function.

# Make this plot work. I've mined it with three errors.
ggplot(aes(cyl), alpha = 0.5) +
  geom_point(mtcars) +
  geom_jitter(aes(y = log(mpg))) +
  scale_x_continuous(name = "Cylinders",
                     breaks = c(4, 6, 8)) +
  scale_y_continuous("Miles per gallon")

# You should produce the same plot as this one: 
# https://github.com/cimentadaj/tidyverse_seminars/blob/master/third_seminar/figures/correct_plot1.png


# 2nd.
# Make a barplot with the `cyl` variable from mtcars and make the fill of each barplot unique
# for each `cyl`. There's a catch: the `cyl` variable doesn't have the right class ;)


# 3rd.
# Reproduce to this graph to the smallest detail:
# https://github.com/cimentadaj/tidyverse_seminars/blob/master/third_seminar/figures/correct_plot2.png

# 4th
# Let's create a layered plot.

# Use the data mtcars with ggplot and specify `mpg` and `disp` as the x and y aesthetics respectively.
# Add a geom_point() to create a scatterplot.
# Add a geom_smooth() to get the wiggly prediction line.


# At this point you have a nice scatterplot. We want to overlay a density plot with the
# distribution of mpg over this plot. We can do that by overlaying a geom_density plot.
# Add geom_density and define the aes() call with mpg as the x variable and
# the ggplot created variable ..density.. as the y variable. Before finishing,
# include inhertir.aes = F outside the aes but inside geom_density to let ggplot know not to use
# the global variables.

# Note that there is a density plot but we can't really see the height because the y variable of
# density is not scaled to be in hundreds like the 'disp' variable. Simply multiply ..density.. by
# 1000 and you should have it scaled

# Finally, add a facet_wrap call with `~ am`` inside to calculate this exact same thing for different
# different `am` subsets.

# Finish by adding a title with ggtitle()

# Voila!
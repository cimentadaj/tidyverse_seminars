# ggplot2 is designed to work in a layered fashion,
# starting with a layer showing the raw data then
# adding layers of annotations and statistical sum- maries.


# It is especially helpful for students who have not yet
# developed the structured approach to analysis used by experts.


# In brief, the grammar tells us that a statistical graphic
# is a mapping from data to aesthetic attributes (colour, shape, size)
# of geometric objects (points, lines, bars). The plot may also contain
# statistical transformations of the data and is drawn on a specific
# coordinate system. Faceting can be used to generate the same plot
# for different subsets of the dataset. It is the combination of
# these independent components that make up a graphic.


# The data that you want to visualise and a set of aesthetic mappings describing how
# variables in the data are mapped to aesthetic attributes that you can perceive.

# • Geometric objects, geoms for short, represent what you actually see on the plot: points,
# lines, polygons, etc.

# • Statistical transformations, stats for short, summarise data in many useful ways.
# For example, binning and counting observations to create a histogram, or summarising
# a 2d relationship with a linear model. Stats are optional, but very useful.

# • The scales map values in the data space to values in an aesthetic space, whether
# it be colour, or size, or shape. Scales draw a legend or axes, which provide an
# inverse mapping to make it possible to read the original data values from the graph.

# • A coordinate system, coord for short, describes how data coordinates are mapped
# to the plane of the graphic. It also provides axes and gridlines to make it possible
# to read the graph. We normally use a Cartesian coordinate system, but a number of
# others are available, including polar coordinates and map projections.

# • A faceting specification describes how to break up the data into subsets and
# how to display those subsets as small multiples. This is also known as conditioning
# or latticing/trellising.



library(tidyverse)

region_states <- setNames(as.character(state.region), state.name)
division_states <- setNames(as.character(state.division), state.name)

upd_bad_drivers <-
  bad_drivers %>%
  filter(state != "District of Columbia") %>%
  mutate(region = region_states[state],
         division = division_states[state])

upd_bad_drivers %>%
  ggplot(aes(perc_speeding, perc_alcohol, colour = region)) +
  geom_point()

upd_bad_drivers %>%
  ggplot(aes(region, perc_alcohol)) +
  geom_jitter()


qplot(color, price / carat, data = diamonds, geom = "jitter",
      alpha = I(1 / 10))

qplot(date, unemploy / pop, data = economics, geom = "line")
qplot(date, uempmed, data = economics, geom = "line")

xlim, ylim
log
log="xy"
xlab, ylab
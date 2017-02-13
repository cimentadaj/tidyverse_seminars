# Ideas for second seminar

tb <- tibble(
  `:)` = "smile", 
  ` ` = "space",
  `2000` = "number"
)


# Also, recycling is onle when vector length == 1 and strings are never turned into factors
# There are two main differences in the usage of a tibble vs. a classic data.frame: printing and subsetting.


# Tibbles are designed so that you don’t accidentally overwhelm your console when
# you print large data frames. But sometimes you need more output than the default display. There are a few options that can help.

df <- tibble(
  x = runif(5),
  y = rnorm(5)
)

df %>%
  select(x)

df %>%
  .$x

df %>%
  .[["x"]]

# Compared to a data.frame, tibbles are more strict: they never do
# partial matching, and they will generate a warning if the column you are trying to access does not exist.

# 2. Compare and contrast the following operations on a data.frame and equivalent tibble. What is different? Why might the default data frame behaviours cause you frustration?

```{r}
df <- data.frame(abc = 1, xyz = "a")
df_tibble <- tibble::tibble(abc = 1, xyz = "a")

# df does partial matching
df$x
df_tibble$x # tibble doesn't
```

```{r}
df[, "xyz"] # returns a factor
df_tibble[, "xyz"] # returns a data frame
```

```{r}
# returns the same thing but xyz is a factor in the data farme and a char in the tibble
df[, c("abc", "xyz")]
df_tibble[, c("abc", "xyz")]
```

3. If you have the name of a variable stored in an object, e.g. var <- "mpg", how can you extract the reference variable from a tibble?

```{r, eval = F}
var <- "abc"

# Will extract the vector
df_tibble[[var]]

# Will select the var and return a tibble
df_tibble[var]
```

The tidyverse
========================================================
author: Jorge Cimentada  
date: 16th of February of 2017  
class: illustration
font-family: 'Helvetica'
width: 1800
height: 900

The philosophy of the tidyverse
========================================================
incremental: true



- What is the tidyverse?

- "The tidyverse is a set of packages that work in harmony because they share common data representations." Hadley Wickham

- They've been created with the same data process in mind.

Remember R packages have been created by thousands of users without a clear structure!

The tidyverse is one attempt at unifying the philosophy of data analysis.

The philosophy of the tidyverse
=======================================================

Yeah, the tidyverse is really just a package that installs other packages:

"The tidyverse package is designed to make it easy to install and load core packages from the tidyverse in a single command." Hadley Wickham  


```r
install.packages("tidyverse")
```

The philosophy of the tidyverse
=======================================================

What is the tidyverse for?

"My goal is to make the  data analysis process a pit of success" Hadley Wickham


<div align="left">
<img src="./figures/data-science.png" width=1000 height=300>
</div>

<small>http://r4ds.had.co.nz/introduction.html</small>

The philosophy of the tidyverse
======================================================

<div align="center">
<img src="./figures/tidyverse_pkgs.png" width=800 height=650>
</div>

The philosophy of the tidyverse
======================================================

- Why TIDYverse?

- Why tidyVERSE?

First..
=======================================================

```r
library(tidyverse)
```

Data visualization
========================================================


```r
library(tidyverse)
library(fivethirtyeight)
police_killings
```

```
# A tibble: 467 × 34
                 name   age gender   raceethnicity    month   day  year
                <chr> <int>  <chr>           <chr>    <chr> <int> <int>
1  A'donte Washington    16   Male           Black February    23  2015
2      Aaron Rutledge    27   Male           White    April     2  2015
3         Aaron Siler    26   Male           White    March    14  2015
4        Aaron Valdez    25   Male Hispanic/Latino    March    11  2015
5        Adam Jovicic    29   Male           White    March    19  2015
6       Adam Reinhart    29   Male           White    March     7  2015
7    Adrian Hernandez    22   Male Hispanic/Latino    March    27  2015
8        Adrian Solis    35   Male Hispanic/Latino    March    26  2015
9       Alan Alverson    44   Male           White  January    28  2015
10         Alan James    31   Male           White February     7  2015
# ... with 457 more rows, and 27 more variables: streetaddress <chr>,
#   city <chr>, state <chr>, latitude <dbl>, longitude <dbl>,
#   state_fp <int>, county_fp <int>, tract_ce <int>, geo_id <dbl>,
#   county_id <int>, namelsad <chr>, lawenforcementagency <chr>,
#   cause <chr>, armed <chr>, pop <int>, share_white <chr>,
#   share_black <chr>, share_hispanic <chr>, p_income <chr>,
#   h_income <chr>, county_income <int>, comp_income <chr>,
#   county_bucket <chr>, nat_bucket <chr>, pov <chr>, urate <chr>,
#   college <chr>
```

Data visualization
========================================================
ggplot structure:


```r
ggplot(data = police_killings) +
  geom_point(mapping = aes(x = as.numeric(pov), y = pop))
```

![plot of chunk unnamed-chunk-5](first_seminar-figure/unnamed-chunk-5-1.png)

Data visualization
========================================================

The `ggplot` function "opens" the data and the `geom` function specifies the type of plot with the variables that will be used.

The general structure is like this:


```r
ggplot(data = <DATA>) + 
  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))
```

Data visualization
========================================================

How many geoms (plots)?

- `geom_point()`
- `geom_bar()`
- `geom_histogram()`
- `geom_boxplot()`
- `geom_density()`
- `geom_line()`
- `geom_smooth()`
- And a bunch more  

[all geoms](http://sape.inf.usi.ch/quick-reference/ggplot2/geom)  
[all ggplot2 extensions](http://www.ggplot2-exts.org/gallery/)

Data visualization
========================================================

Let's look at the data again..


```
# A tibble: 467 × 34
                 name   age gender   raceethnicity    month   day  year
                <chr> <int>  <chr>           <chr>    <chr> <int> <int>
1  A'donte Washington    16   Male           Black February    23  2015
2      Aaron Rutledge    27   Male           White    April     2  2015
3         Aaron Siler    26   Male           White    March    14  2015
4        Aaron Valdez    25   Male Hispanic/Latino    March    11  2015
5        Adam Jovicic    29   Male           White    March    19  2015
6       Adam Reinhart    29   Male           White    March     7  2015
7    Adrian Hernandez    22   Male Hispanic/Latino    March    27  2015
8        Adrian Solis    35   Male Hispanic/Latino    March    26  2015
9       Alan Alverson    44   Male           White  January    28  2015
10         Alan James    31   Male           White February     7  2015
# ... with 457 more rows, and 27 more variables: streetaddress <chr>,
#   city <chr>, state <chr>, latitude <dbl>, longitude <dbl>,
#   state_fp <int>, county_fp <int>, tract_ce <int>, geo_id <dbl>,
#   county_id <int>, namelsad <chr>, lawenforcementagency <chr>,
#   cause <chr>, armed <chr>, pop <int>, share_white <chr>,
#   share_black <chr>, share_hispanic <chr>, p_income <chr>,
#   h_income <chr>, county_income <int>, comp_income <chr>,
#   county_bucket <chr>, nat_bucket <chr>, pov <chr>, urate <chr>,
#   college <chr>
```

Data visualization
========================================================


```r
police_killings$pov <- as.numeric(police_killings$pov)
police_killings$p_income <- as.numeric(police_killings$p_income)

# colour
ggplot(data = police_killings) +
  geom_point(mapping = aes(x = pov, y = pop,
                           colour = p_income > mean(p_income, na.rm = T)))

# size
ggplot(data = police_killings) +
  geom_point(mapping = aes(x = pov, y = pop,
                           size = as.numeric(urate)))

# shape
ggplot(data = police_killings) +
  geom_point(mapping = aes(x = pov, y = pop,
                           shape = p_income > mean(p_income, na.rm = T)))

# alpha (transparency)
ggplot(data = police_killings) +
  geom_point(mapping = aes(x = pov, y = pop,
                           alpha = p_income > mean(p_income, na.rm = T)))
```

Data visualization
========================================================

All of these aesthetics can be used outside the `aes()` wrapper.


```r
# colour
ggplot(data = police_killings) +
  geom_point(mapping = aes(x = pov, y = pop), colour = "blue")

# size
ggplot(data = police_killings) +
  geom_point(mapping = aes(x = pov, y = pop), size = 2.5)

# shape
ggplot(data = police_killings) +
  geom_point(mapping = aes(x = pov, y = pop), shape = 24)

# alpha (transparency)
ggplot(data = police_killings) +
  geom_point(mapping = aes(x = pov, y = pop), alpha = 0.2)
```

Data visualization
========================================================

Aesthetics vary by `geom_*()` functions so you should have a look at the documentation before using it.

- `alpha`
- `colour`
- `fill`
- `group`
- `shape`
- `size`
- `stroke`

Are common ones..

Data visualization
========================================================

Let's try it out:

We want to create a scatterplot to look at the relationship between the % of black within the county and the median household income. This will help to establish whether counties with black majority are associated with lower household income.

Hints:
- x var = `as.numeric(share_black)`
- y var = `as.numeric(h_income)`
- data name = `police_killings`
- geom = `geom_point()`


Data visualization
========================================================

Answer:


```r
ggplot(data = police_killings) +
  geom_point(aes(x = as.numeric(share_black),
                 y = as.numeric(h_income)))
```

![plot of chunk unnamed-chunk-10](first_seminar-figure/unnamed-chunk-10-1.png)

Data visualization
========================================================

Let's add the size of the points to be a function of the population in the county.

Hints:
- aesthetic = `size`
- variable = `pop`

Data visualization
========================================================

Answer:


```r
ggplot(data = police_killings) +
  geom_point(aes(x = as.numeric(share_black),
                 y = as.numeric(h_income), size = pop))
```

![plot of chunk unnamed-chunk-11](first_seminar-figure/unnamed-chunk-11-1.png)

Too many dots! It doesn't look that nice. Let's add `alpha = 0.3`

Data visualization
========================================================

Answer:


```r
ggplot(data = police_killings) +
  geom_point(aes(x = as.numeric(share_black),
                 y = as.numeric(h_income),
                 size = pop),
             alpha = 0.30)
```

![plot of chunk unnamed-chunk-12](first_seminar-figure/unnamed-chunk-12-1.png)

Data visualization
========================================================

Let's color counties based on whether they are above/below the mean unemployment rate which is 0.11:

Hint:
- aesthetic = `colour` or `color`
- variable = `as.numeric(police_killings$urate) > 0.11`

Data visualization
========================================================

Answer:


```r
ggplot(data = police_killings) +
  geom_point(aes(x = as.numeric(share_black),
                 y = as.numeric(h_income),
                 size = pop,
                 colour = as.numeric(police_killings$urate) > 0.11),
             alpha = 0.30)
```

![plot of chunk unnamed-chunk-13](first_seminar-figure/unnamed-chunk-13-1.png)


Data visualization
========================================================

Let's move everything to the `ggplot()` call


```r
ggplot(data = police_killings,
       aes(x = as.numeric(share_black),
                 y = as.numeric(h_income),
                 size = pop,
                 colour = as.numeric(police_killings$urate) > 0.11)) +
  geom_point(alpha = 0.30)
```


Data visualization
========================================================

Finally, let's add the a regression line for each group:


```r
ggplot(data = police_killings,
       aes(x = as.numeric(share_black),
           y = as.numeric(h_income),
           colour = as.numeric(police_killings$urate) > 0.11)) +
  geom_point(aes(size = pop), alpha = 0.30) +
  geom_smooth(method = "lm")
```

![plot of chunk unnamed-chunk-15](first_seminar-figure/unnamed-chunk-15-1.png)

So much done with just a few lines!

Data visualization
========================================================

Other graphs:


```r
ggplot(police_killings, aes(x = age)) +
  geom_histogram(bins = 55)
```

![plot of chunk unnamed-chunk-16](first_seminar-figure/unnamed-chunk-16-1.png)

Data visualization
========================================================

Other graphs:


```r
ggplot(police_killings, aes(x = raceethnicity)) +
  geom_bar()
```

![plot of chunk unnamed-chunk-17](first_seminar-figure/unnamed-chunk-17-1.png)

Data visualization
========================================================

Other graphs:


```r
ggplot(police_killings, aes(x = raceethnicity, y = age)) +
  geom_boxplot()
```

![plot of chunk unnamed-chunk-18](first_seminar-figure/unnamed-chunk-18-1.png)

Data visualization
========================================================

It's not far fetched to say that this is truly the surface of what ggplot2 can do.
To learn ggplot2:

[R graph coobook](http://www.cookbook-r.com/Graphs/)  
[ggplot2 book by its author](http://ggplot2.org/book/)  
[R for Data Science](http://r4ds.had.co.nz/)  




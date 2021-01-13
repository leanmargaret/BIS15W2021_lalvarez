---
title: "Lab 3 Homework"
author: "Lean Alvarez"
date: "2021-01-12"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---

## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the tidyverse

```r
library(tidyverse)
```



```r
getwd()
```

```
## [1] "/Users/alvarezlean/Desktop/BIS15W2021_lalvarez/lab3"
```

## Mammals Sleep
1. For this assignment, we are going to use built-in data on mammal sleep patterns. From which publication are these data taken from? Since the data are built-in you can use the help function in R.

```r
?msleep
```
These data are taken from the National Academy of Sciences, 104 (3):1051-1056, 2007.


2. Store these data into a new data frame `sleep`.

```r
sleep <- msleep
```



3. What are the dimensions of this data frame (variables and observations)? How do you know? Please show the *code* that you used to determine this below.  

```r
dim(sleep)
```

```
## [1] 83 11
```
The dimensions are: 83 rows and 11 columns. I determined this using the code dim().



4. Are there any NAs in the data? How did you determine this? Please show your code.  

```r
anyNA(sleep)
```

```
## [1] TRUE
```
There are NAs in the data. I determined this by using the code anyNA().


5. Show a list of the column names is this data frame.

```r
names(sleep)
```

```
##  [1] "name"         "genus"        "vore"         "order"        "conservation"
##  [6] "sleep_total"  "sleep_rem"    "sleep_cycle"  "awake"        "brainwt"     
## [11] "bodywt"
```



6. How many herbivores are represented in the data?  

```r
herbivores <- subset(sleep, vore=="herbi")
herbivores
```

```
## # A tibble: 32 x 11
##    name  genus vore  order conservation sleep_total sleep_rem sleep_cycle awake
##    <chr> <chr> <chr> <chr> <chr>              <dbl>     <dbl>       <dbl> <dbl>
##  1 Moun… Aplo… herbi Rode… nt                  14.4       2.4      NA       9.6
##  2 Cow   Bos   herbi Arti… domesticated         4         0.7       0.667  20  
##  3 Thre… Brad… herbi Pilo… <NA>                14.4       2.2       0.767   9.6
##  4 Roe … Capr… herbi Arti… lc                   3        NA        NA      21  
##  5 Goat  Capri herbi Arti… lc                   5.3       0.6      NA      18.7
##  6 Guin… Cavis herbi Rode… domesticated         9.4       0.8       0.217  14.6
##  7 Chin… Chin… herbi Rode… domesticated        12.5       1.5       0.117  11.5
##  8 Tree… Dend… herbi Hyra… lc                   5.3       0.5      NA      18.7
##  9 Asia… Elep… herbi Prob… en                   3.9      NA        NA      20.1
## 10 Horse Equus herbi Peri… domesticated         2.9       0.6       1      21.1
## # … with 22 more rows, and 2 more variables: brainwt <dbl>, bodywt <dbl>
```

```r
nrow(herbivores)
```

```
## [1] 32
```



7. We are interested in two groups; small and large mammals. Let's define small as less than or equal to 1kg body weight and large as greater than or equal to 200kg body weight. Make two new dataframes (large and small) based on these parameters.

```r
small <- subset(sleep, bodywt<=1)
small
```

```
## # A tibble: 36 x 11
##    name  genus vore  order conservation sleep_total sleep_rem sleep_cycle awake
##    <chr> <chr> <chr> <chr> <chr>              <dbl>     <dbl>       <dbl> <dbl>
##  1 Owl … Aotus omni  Prim… <NA>                17         1.8      NA       7  
##  2 Grea… Blar… omni  Sori… lc                  14.9       2.3       0.133   9.1
##  3 Vesp… Calo… <NA>  Rode… <NA>                 7        NA        NA      17  
##  4 Guin… Cavis herbi Rode… domesticated         9.4       0.8       0.217  14.6
##  5 Chin… Chin… herbi Rode… domesticated        12.5       1.5       0.117  11.5
##  6 Star… Cond… omni  Sori… lc                  10.3       2.2      NA      13.7
##  7 Afri… Cric… omni  Rode… <NA>                 8.3       2        NA      15.7
##  8 Less… Cryp… omni  Sori… lc                   9.1       1.4       0.15   14.9
##  9 Big … Epte… inse… Chir… lc                  19.7       3.9       0.117   4.3
## 10 Euro… Erin… omni  Erin… lc                  10.1       3.5       0.283  13.9
## # … with 26 more rows, and 2 more variables: brainwt <dbl>, bodywt <dbl>
```


```r
large <- subset(sleep, bodywt>=200)
large
```

```
## # A tibble: 7 x 11
##   name  genus vore  order conservation sleep_total sleep_rem sleep_cycle awake
##   <chr> <chr> <chr> <chr> <chr>              <dbl>     <dbl>       <dbl> <dbl>
## 1 Cow   Bos   herbi Arti… domesticated         4         0.7       0.667  20  
## 2 Asia… Elep… herbi Prob… en                   3.9      NA        NA      20.1
## 3 Horse Equus herbi Peri… domesticated         2.9       0.6       1      21.1
## 4 Gira… Gira… herbi Arti… cd                   1.9       0.4      NA      22.1
## 5 Pilo… Glob… carni Ceta… cd                   2.7       0.1      NA      21.4
## 6 Afri… Loxo… herbi Prob… vu                   3.3      NA        NA      20.7
## 7 Braz… Tapi… herbi Peri… vu                   4.4       1         0.9    19.6
## # … with 2 more variables: brainwt <dbl>, bodywt <dbl>
```


8. What is the mean weight for both the small and large mammals?

```r
colMeans(small[,11])
```

```
##    bodywt 
## 0.2596667
```


```r
colMeans(large[,11])
```

```
##   bodywt 
## 1747.071
```



9. Using a similar approach as above, do large or small animals sleep longer on average?  

```r
colMeans(small[,6])
```

```
## sleep_total 
##    12.65833
```


```r
colMeans(large[,6])
```

```
## sleep_total 
##         3.3
```
Small animals sleep longer on average.



10. Which animal is the sleepiest among the entire dataframe?

```r
sleepiest <- subset(sleep, sleep_total==max(sleep_total))
sleepiest
```

```
## # A tibble: 1 x 11
##   name  genus vore  order conservation sleep_total sleep_rem sleep_cycle awake
##   <chr> <chr> <chr> <chr> <chr>              <dbl>     <dbl>       <dbl> <dbl>
## 1 Litt… Myot… inse… Chir… <NA>                19.9         2         0.2   4.1
## # … with 2 more variables: brainwt <dbl>, bodywt <dbl>
```
The little brown bat is the sleepiest.

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   

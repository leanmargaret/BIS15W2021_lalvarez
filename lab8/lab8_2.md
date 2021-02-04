---
title: "Tidyr 2: `pivot_wider()`"
date: "2021-02-04"
output:
  html_document: 
    theme: spacelab
    toc: yes
    toc_float: yes
    keep_md: yes
  pdf_document:
    toc: yes
---

## Learning Goals
*At the end of this exercise, you will be able to:*    
1. Explain the difference between tidy and messy data.  
2. Evaluate a data set as tidy or untidy.  
3. Use the `pivot_wider()` function of `tidyr` to transform data from long to wide format.  

## Breakout Rooms  
Please take 5-8 minutes to check over your answers to HW 7 in your group. If you are stuck, please remember that you can check the key in [Joel's repository](https://github.com/jmledford3115/BIS15LW2021_jledford).  

## Midterm 1 Review
Let's briefly review the questions from midterm 1 so you can get an idea of how I was thinking about the problems. Remember, there is more than one way to get at these answers, so don't worry if yours looks different than mine!  

## Group Project
Let's take a few minutes to discuss group projects. What data interest you? Make a plan on doing some internet searches and thinking about data that might work. Think about the kinds of questions you might ask and how they might be addressed. Please complete the [class project survey](https://forms.gle/EJkbGyHN5MycyQpSA) as part of your homework.  

## Resources
- [tidyr `pivot_wider()`](https://tidyr.tidyverse.org/reference/pivot_wider.html)  
- [pivoting](https://cran.r-project.org/web/packages/tidyr/vignettes/pivot.html)  
- [R Ladies Sydney](https://rladiessydney.org/courses/ryouwithme/02-cleanitup-5/)  

## Review
Last time we learned the fundamentals of tidy data and used the `pivot_longer()` function to wrangle a few examples of frequently encountered untidy data. In the second part of today's lab we will look at a few more examples of `pivot_longer()` but also use the `pivot_wider()` function to deal with another type of untidy data.  

## Load the tidyverse

```r
library("tidyverse")
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
```

```
## ✓ ggplot2 3.3.3     ✓ purrr   0.3.4
## ✓ tibble  3.0.6     ✓ dplyr   1.0.4
## ✓ tidyr   1.1.2     ✓ stringr 1.4.0
## ✓ readr   1.4.0     ✓ forcats 0.5.1
```

```
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

## `pivot_longer()`
Recall that we use `pivot_longer()` when our column names actually represent variables. A classic example would be that the column names represent observations of a variable.

```r
datasets::USPersonalExpenditure
```

```
##                       1940   1945  1950 1955  1960
## Food and Tobacco    22.200 44.500 59.60 73.2 86.80
## Household Operation 10.500 15.500 29.00 36.5 46.20
## Medical and Health   3.530  5.760  9.71 14.0 21.10
## Personal Care        1.040  1.980  2.45  3.4  5.40
## Private Education    0.341  0.974  1.80  2.6  3.64
```

```r
?USPersonalExpenditure
```

Here we add a new column of expenditure types, which are stored as rownames above, with `mutate()`. The `USPersonalExpenditures` data also needs to be converted to a data frame before we can use the tidyverse functions, because it comes as a matrix.

```r
expenditures <- 
  USPersonalExpenditure %>% 
  as_tibble() %>% 
  mutate(expenditure = rownames(USPersonalExpenditure))
expenditures
```

```
## # A tibble: 5 x 6
##   `1940` `1945` `1950` `1955` `1960` expenditure        
##    <dbl>  <dbl>  <dbl>  <dbl>  <dbl> <chr>              
## 1 22.2   44.5    59.6    73.2  86.8  Food and Tobacco   
## 2 10.5   15.5    29      36.5  46.2  Household Operation
## 3  3.53   5.76    9.71   14    21.1  Medical and Health 
## 4  1.04   1.98    2.45    3.4   5.4  Personal Care      
## 5  0.341  0.974   1.8     2.6   3.64 Private Education
```

## Practice
1. Are these data tidy? Please use `pivot_longer()` to tidy the data.

```r
expenditures%>% 
  pivot_longer(-expenditure,
               names_to="year",
               values_to="bn_dollars"
               )
```

```
## # A tibble: 25 x 3
##    expenditure         year  bn_dollars
##    <chr>               <chr>      <dbl>
##  1 Food and Tobacco    1940        22.2
##  2 Food and Tobacco    1945        44.5
##  3 Food and Tobacco    1950        59.6
##  4 Food and Tobacco    1955        73.2
##  5 Food and Tobacco    1960        86.8
##  6 Household Operation 1940        10.5
##  7 Household Operation 1945        15.5
##  8 Household Operation 1950        29  
##  9 Household Operation 1955        36.5
## 10 Household Operation 1960        46.2
## # … with 15 more rows
```

2. Restrict the data to medical and health expenditures only. Sort in ascending order.

```r
expenditures %>% 
  pivot_longer(-expenditure,
               names_to="year",
               values_to="bn_dollars"
               ) %>% 
  filter(expenditure=="Medical and Health") %>% 
  arrange(bn_dollars)
```

```
## # A tibble: 5 x 3
##   expenditure        year  bn_dollars
##   <chr>              <chr>      <dbl>
## 1 Medical and Health 1940        3.53
## 2 Medical and Health 1945        5.76
## 3 Medical and Health 1950        9.71
## 4 Medical and Health 1955       14   
## 5 Medical and Health 1960       21.1
```

## `separate()`
In this new heart rate example, we have the sex of each patient included with their name. Are these data tidy? No, there is more than one value per cell in the patient column and the columns a, b, c, d once again represent values.

```r
heartrate2 <- readr::read_csv("data/heartrate2.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   patient = col_character(),
##   a = col_double(),
##   b = col_double(),
##   c = col_double(),
##   d = col_double()
## )
```

```r
heartrate2
```

```
## # A tibble: 6 x 5
##   patient        a     b     c     d
##   <chr>      <dbl> <dbl> <dbl> <dbl>
## 1 Margaret_f    72    74    80    68
## 2 Frank_m       84    84    88    76
## 3 Hawkeye_m     64    66    68    64
## 4 Trapper_m     60    58    64    58
## 5 Radar_m       74    72    78    70
## 6 Henry_m       88    87    88    72
```

We need to start by separating the patient names from their sexes. `separate()` needs to know which column you want to split, the names of the new columns, and what to look for in terms of breaks in the data.

```r
heartrate2 %>% 
  separate(patient, into= c("patient", "sex"), sep = "_")
```

```
## # A tibble: 6 x 6
##   patient  sex       a     b     c     d
##   <chr>    <chr> <dbl> <dbl> <dbl> <dbl>
## 1 Margaret f        72    74    80    68
## 2 Frank    m        84    84    88    76
## 3 Hawkeye  m        64    66    68    64
## 4 Trapper  m        60    58    64    58
## 5 Radar    m        74    72    78    70
## 6 Henry    m        88    87    88    72
```
-but data still not tidy


## Practice
1. Re-examine `heartrate2`. Use `separate()` for the sexes, `pivot_longer()` to tidy, and `arrange()` to organize by patient and drug. Store this as a new object `heartrate3`.  

```r
heartrate3 <- heartrate2 %>% 
  separate(patient, into= c("patient", "sex"), sep = "_") %>% 
  pivot_longer(-c(patient, sex),
               names_to="drug",
               values_to="heartrate"
               )
heartrate3  
```

```
## # A tibble: 24 x 4
##    patient  sex   drug  heartrate
##    <chr>    <chr> <chr>     <dbl>
##  1 Margaret f     a            72
##  2 Margaret f     b            74
##  3 Margaret f     c            80
##  4 Margaret f     d            68
##  5 Frank    m     a            84
##  6 Frank    m     b            84
##  7 Frank    m     c            88
##  8 Frank    m     d            76
##  9 Hawkeye  m     a            64
## 10 Hawkeye  m     b            66
## # … with 14 more rows
```

2. `unite()` is the opposite of separate(). Its syntax is straightforward. You only need to give a new column name and then list the columns to combine with a separation character.  Give it a try below by recombining patient and sex from `heartrate3`.  

```r
heartrate3_unite <- heartrate3 %>% 
  unite(patient_sex, "patient", "sex", sep = "_")
heartrate3_unite
```

```
## # A tibble: 24 x 3
##    patient_sex drug  heartrate
##    <chr>       <chr>     <dbl>
##  1 Margaret_f  a            72
##  2 Margaret_f  b            74
##  3 Margaret_f  c            80
##  4 Margaret_f  d            68
##  5 Frank_m     a            84
##  6 Frank_m     b            84
##  7 Frank_m     c            88
##  8 Frank_m     d            76
##  9 Hawkeye_m   a            64
## 10 Hawkeye_m   b            66
## # … with 14 more rows
```

## `pivot_wider()`
The opposite of `pivot_longer()`. You use `pivot_wider()` when you have an observation scattered across multiple rows. In the example below, `cases` and `population` represent variable names not observations.  

Rules:  
+ `pivot_wider`(names_from, values_from)  
+ `names_from` - Values in the `names_from` column will become new column names  
+ `values_from` - Cell values will be taken from the `values_from` column  


```r
tb_data <- read_csv("data/tb_data.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   country = col_character(),
##   year = col_double(),
##   key = col_character(),
##   value = col_double()
## )
```

```r
tb_data
```

```
## # A tibble: 12 x 4
##    country      year key             value
##    <chr>       <dbl> <chr>           <dbl>
##  1 Afghanistan  1999 cases             745
##  2 Afghanistan  1999 population   19987071
##  3 Afghanistan  2000 cases            2666
##  4 Afghanistan  2000 population   20595360
##  5 Brazil       1999 cases           37737
##  6 Brazil       1999 population  172006362
##  7 Brazil       2000 cases           80488
##  8 Brazil       2000 population  174504898
##  9 China        1999 cases          212258
## 10 China        1999 population 1272915272
## 11 China        2000 cases          213766
## 12 China        2000 population 1280428583
```

When using `pivot_wider()` we use `names_from` to identify the variables (new column names) and `values_from` to identify the values associated with the new columns.

```r
tb_data %>% 
  pivot_wider(names_from = "key", #the observations under key will become new columns
              values_from = "value")
```

```
## # A tibble: 6 x 4
##   country      year  cases population
##   <chr>       <dbl>  <dbl>      <dbl>
## 1 Afghanistan  1999    745   19987071
## 2 Afghanistan  2000   2666   20595360
## 3 Brazil       1999  37737  172006362
## 4 Brazil       2000  80488  174504898
## 5 China        1999 212258 1272915272
## 6 China        2000 213766 1280428583
```

## Practice
1. Load the `gene_exp.csv` data as a new object `gene_exp`. Are these data tidy? Use `pivot_wider()` to tidy the data.

```r
gene_exp <- readr::read_csv("data/gene_exp.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   gene_id = col_character(),
##   type = col_character(),
##   L4_values = col_double()
## )
```

```r
gene_exp
```

```
## # A tibble: 6 x 3
##   gene_id type      L4_values
##   <chr>   <chr>         <dbl>
## 1 gene1   treatment      15.6
## 2 gene1   control        19.3
## 3 gene2   treatment      22.2
## 4 gene2   control        16.0
## 5 gene3   treatment      17.7
## 6 gene3   control        26.9
```


```r
gene_exp %>% 
  pivot_wider(names_from = "type",
              values_from = "L4_values")
```

```
## # A tibble: 3 x 3
##   gene_id treatment control
##   <chr>       <dbl>   <dbl>
## 1 gene1        15.6    19.3
## 2 gene2        22.2    16.0
## 3 gene3        17.7    26.9
```
-not tidy bc treatment and control are part of data

## `pivot_wider()` with multiple variables  
What happens when we want to use `pivot_wider()` with multiple columns?

```r
edu_level <- readr::read_csv("data/education_level.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   sex = col_character(),
##   race = col_character(),
##   education_level = col_character(),
##   mean_income = col_double(),
##   n = col_double()
## )
```

```r
edu_level
```

```
## # A tibble: 8 x 5
##   sex   race  education_level mean_income     n
##   <chr> <chr> <chr>                 <dbl> <dbl>
## 1 F     B     BA                     99.2   110
## 2 F     B     HS                    100.    104
## 3 F     W     BA                     94.5   125
## 4 F     W     HS                     97.5   141
## 5 M     B     BA                     93.8   126
## 6 M     B     HS                     94.6   129
## 7 M     W     BA                    103.    138
## 8 M     W     HS                    103.    127
```

We want to pivot the `edu_level` data such that there is only a single row per demographic. 

```r
edu_level %>% 
pivot_wider(names_from = (education_level), #new column names come from the education_level column
                values_from = c(mean_income, n)) #values come from two separate columns
```

```
## # A tibble: 4 x 6
##   sex   race  mean_income_BA mean_income_HS  n_BA  n_HS
##   <chr> <chr>          <dbl>          <dbl> <dbl> <dbl>
## 1 F     B               99.2          100.    110   104
## 2 F     W               94.5           97.5   125   141
## 3 M     B               93.8           94.6   126   129
## 4 M     W              103.           103.    138   127
```

## Practice
For the last practice example, I will use data from the awesome [R Ladies Sydney](https://rladiessydney.org/courses/ryouwithme/02-cleanitup-5/) blog. This data set is compiled by the NSW Office of Environment and Heritage contains the enterococci counts in water samples obtained from Sydney beaches as part of the Beachwatch Water Quality Program! The data set we’ll be working with is current as of October 13th 2018.  

1. Load the beachbugs data and have a look.

```r
beachbugs <- readr::read_csv("data/beachbugs_long.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   year = col_double(),
##   site = col_character(),
##   buglevels = col_double()
## )
```

```r
beachbugs
```

```
## # A tibble: 66 x 3
##     year site                    buglevels
##    <dbl> <chr>                       <dbl>
##  1  2013 Bondi Beach                 32.2 
##  2  2013 Bronte Beach                26.8 
##  3  2013 Clovelly Beach               9.28
##  4  2013 Coogee Beach                39.7 
##  5  2013 Gordons Bay (East)          24.8 
##  6  2013 Little Bay Beach           122.  
##  7  2013 Malabar Beach              101.  
##  8  2013 Maroubra Beach              47.1 
##  9  2013 South Maroubra Beach        39.3 
## 10  2013 South Maroubra Rockpool     96.4 
## # … with 56 more rows
```
2. Use `pivot_wider` to transform the data into wide format.

```r
beachbugs_wider <- beachbugs %>% 
  pivot_wider(names_from="site",
              values_from="buglevels")
beachbugs_wider
```

```
## # A tibble: 6 x 12
##    year `Bondi Beach` `Bronte Beach` `Clovelly Beach` `Coogee Beach`
##   <dbl>         <dbl>          <dbl>            <dbl>          <dbl>
## 1  2013          32.2           26.8             9.28           39.7
## 2  2014          11.1           17.5            13.8            52.6
## 3  2015          14.3           23.6             8.82           40.3
## 4  2016          19.4           61.3            11.3            59.5
## 5  2017          13.2           16.8             7.93           20.7
## 6  2018          22.9           43.4            10.6            21.6
## # … with 7 more variables: `Gordons Bay (East)` <dbl>, `Little Bay
## #   Beach` <dbl>, `Malabar Beach` <dbl>, `Maroubra Beach` <dbl>, `South
## #   Maroubra Beach` <dbl>, `South Maroubra Rockpool` <dbl>, `Tamarama
## #   Beach` <dbl>
```
3. Now, use `pivot_longer` to transform them back to long!

```r
beachbugs_longer <- beachbugs_wider %>% 
  pivot_longer(-year,
               names_to="site",
               values_to="buglevels")
beachbugs_longer
```

```
## # A tibble: 66 x 3
##     year site                    buglevels
##    <dbl> <chr>                       <dbl>
##  1  2013 Bondi Beach                 32.2 
##  2  2013 Bronte Beach                26.8 
##  3  2013 Clovelly Beach               9.28
##  4  2013 Coogee Beach                39.7 
##  5  2013 Gordons Bay (East)          24.8 
##  6  2013 Little Bay Beach           122.  
##  7  2013 Malabar Beach              101.  
##  8  2013 Maroubra Beach              47.1 
##  9  2013 South Maroubra Beach        39.3 
## 10  2013 South Maroubra Rockpool     96.4 
## # … with 56 more rows
```

## Wrap-up  
Please review the learning goals and be sure to use the code here as a reference when completing the homework.  
-->[Home](https://jmledford3115.github.io/datascibiol/)

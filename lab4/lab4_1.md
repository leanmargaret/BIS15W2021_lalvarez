---
title: "Transforming data 1: Dplyr `select()`"
date: "2021-01-16"
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
1. Use summary functions to assess the structure of a data frame.  
2. Us the select function of `dplyr` to build data frames restricted to variable of interest.  
3. Use the `rename()` function to provide new, consistent names to variables in data frames.  

## Review
At this point, you should have familiarity in RStudio, GitHub, and basic operations in R. If you need extra help, please [email me](mailto: jmledford@ucdavis.edu).  

## Load the tidyverse
For the remainder of the quarter, we will work within the `tidyverse`. At the start of each lab, the library needs to be called as shown below.  

```r
library("tidyverse")
```

## Load the data
These data are from: Gaeta J., G. Sass, S. Carpenter. 2012. Biocomplexity at North Temperate Lakes LTER: Coordinated Field Studies: Large Mouth Bass Growth 2006. Environmental Data Initiative.  [link](https://portal.edirepository.org/nis/mapbrowse?scope=knb-lter-ntl&identifier=267)  

```r
fish <- readr::read_csv("data/Gaeta_etal_CLC_data.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   lakeid = col_character(),
##   fish_id = col_double(),
##   annnumber = col_character(),
##   length = col_double(),
##   radii_length_mm = col_double(),
##   scalelength = col_double()
## )
```

## Data Structure
Once data have been uploaded, let's get an idea of its structure, contents, and dimensions.  

```r
glimpse(fish)
```

```
## Rows: 4,033
## Columns: 6
## $ lakeid          <chr> "AL", "AL", "AL", "AL", "AL", "AL", "AL", "AL", "AL",…
## $ fish_id         <dbl> 299, 299, 299, 300, 300, 300, 300, 301, 301, 301, 301…
## $ annnumber       <chr> "EDGE", "2", "1", "EDGE", "3", "2", "1", "EDGE", "3",…
## $ length          <dbl> 167, 167, 167, 175, 175, 175, 175, 194, 194, 194, 194…
## $ radii_length_mm <dbl> 2.697443, 2.037518, 1.311795, 3.015477, 2.670733, 2.1…
## $ scalelength     <dbl> 2.697443, 2.697443, 2.697443, 3.015477, 3.015477, 3.0…
```

```r
str(fish)
```

```
## tibble [4,033 × 6] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
##  $ lakeid         : chr [1:4033] "AL" "AL" "AL" "AL" ...
##  $ fish_id        : num [1:4033] 299 299 299 300 300 300 300 301 301 301 ...
##  $ annnumber      : chr [1:4033] "EDGE" "2" "1" "EDGE" ...
##  $ length         : num [1:4033] 167 167 167 175 175 175 175 194 194 194 ...
##  $ radii_length_mm: num [1:4033] 2.7 2.04 1.31 3.02 2.67 ...
##  $ scalelength    : num [1:4033] 2.7 2.7 2.7 3.02 3.02 ...
##  - attr(*, "spec")=
##   .. cols(
##   ..   lakeid = col_character(),
##   ..   fish_id = col_double(),
##   ..   annnumber = col_character(),
##   ..   length = col_double(),
##   ..   radii_length_mm = col_double(),
##   ..   scalelength = col_double()
##   .. )
```

```r
summary(fish)
```

```
##     lakeid             fish_id       annnumber             length     
##  Length:4033        Min.   :  1.0   Length:4033        Min.   : 58.0  
##  Class :character   1st Qu.:156.0   Class :character   1st Qu.:253.0  
##  Mode  :character   Median :267.0   Mode  :character   Median :299.0  
##                     Mean   :258.3                      Mean   :293.3  
##                     3rd Qu.:376.0                      3rd Qu.:342.0  
##                     Max.   :478.0                      Max.   :420.0  
##  radii_length_mm    scalelength     
##  Min.   : 0.4569   Min.   : 0.6282  
##  1st Qu.: 2.3252   1st Qu.: 4.2596  
##  Median : 3.5380   Median : 5.4062  
##  Mean   : 3.6589   Mean   : 5.3821  
##  3rd Qu.: 4.8229   3rd Qu.: 6.4145  
##  Max.   :11.0258   Max.   :11.0258
```

```r
names(fish)
```

```
## [1] "lakeid"          "fish_id"         "annnumber"       "length"         
## [5] "radii_length_mm" "scalelength"
```

## Tidyverse
The [tidyverse](www.tidyverse.org) is an "opinionated" collection of packages that make workflow in R easier. The packages operate more intuitively than base R commands and share a common organizational philosophy.  
![*Data Science Workflow in the Tidyverse.*](tidy-1.png)  

## dplyr
The first package that we will use that is part of the tidyverse is `dplyr`. `dplyr` is used to transform data frames by extracting, rearranging, and summarizing data such that they are focused on a question of interest. This is very helpful,  especially when wrangling large data, and makes dplyr one of most frequently used packages in the tidyverse. The two functions we will use most are `select()` and `filter()`.  

## `select()`
Select allows you to pull out columns of interest from a dataframe. To do this, just add the names of the columns to the `select()` command. The order in which you add them, will determine the order in which they appear in the output.

```r
names(fish)
```

```
## [1] "lakeid"          "fish_id"         "annnumber"       "length"         
## [5] "radii_length_mm" "scalelength"
```

We are only interested in lakeid and scalelength.

```r
select(fish, "lakeid", "scalelength")
```

```
## # A tibble: 4,033 x 2
##    lakeid scalelength
##    <chr>        <dbl>
##  1 AL            2.70
##  2 AL            2.70
##  3 AL            2.70
##  4 AL            3.02
##  5 AL            3.02
##  6 AL            3.02
##  7 AL            3.02
##  8 AL            3.34
##  9 AL            3.34
## 10 AL            3.34
## # … with 4,023 more rows
```

To add a range of columns use `start_col:end_col`.

```r
fish
```

```
## # A tibble: 4,033 x 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AL         299 EDGE         167            2.70        2.70
##  2 AL         299 2            167            2.04        2.70
##  3 AL         299 1            167            1.31        2.70
##  4 AL         300 EDGE         175            3.02        3.02
##  5 AL         300 3            175            2.67        3.02
##  6 AL         300 2            175            2.14        3.02
##  7 AL         300 1            175            1.23        3.02
##  8 AL         301 EDGE         194            3.34        3.34
##  9 AL         301 3            194            2.97        3.34
## 10 AL         301 2            194            2.29        3.34
## # … with 4,023 more rows
```


```r
select(fish, fish_id:length)
```

```
## # A tibble: 4,033 x 3
##    fish_id annnumber length
##      <dbl> <chr>      <dbl>
##  1     299 EDGE         167
##  2     299 2            167
##  3     299 1            167
##  4     300 EDGE         175
##  5     300 3            175
##  6     300 2            175
##  7     300 1            175
##  8     301 EDGE         194
##  9     301 3            194
## 10     301 2            194
## # … with 4,023 more rows
```

The - operator is useful in select. It allows us to select everything except the specified variables.

```r
select(fish, -fish_id, -annnumber, -length, -radii_length_mm)
```

```
## # A tibble: 4,033 x 2
##    lakeid scalelength
##    <chr>        <dbl>
##  1 AL            2.70
##  2 AL            2.70
##  3 AL            2.70
##  4 AL            3.02
##  5 AL            3.02
##  6 AL            3.02
##  7 AL            3.02
##  8 AL            3.34
##  9 AL            3.34
## 10 AL            3.34
## # … with 4,023 more rows
```

For very large data frames with lots of variables, `select()` utilizes lots of different operators to make things easier. Let's say we are only interested in the variables that deal with length.
-SELECT ALWAYS WORKS WITH COLUMN NAMES


```r
names(fish)
```

```
## [1] "lakeid"          "fish_id"         "annnumber"       "length"         
## [5] "radii_length_mm" "scalelength"
```


```r
select(fish, contains("length"))
```

```
## # A tibble: 4,033 x 3
##    length radii_length_mm scalelength
##     <dbl>           <dbl>       <dbl>
##  1    167            2.70        2.70
##  2    167            2.04        2.70
##  3    167            1.31        2.70
##  4    175            3.02        3.02
##  5    175            2.67        3.02
##  6    175            2.14        3.02
##  7    175            1.23        3.02
##  8    194            3.34        3.34
##  9    194            2.97        3.34
## 10    194            2.29        3.34
## # … with 4,023 more rows
```

When columns are sequentially named, `starts_with()` makes selecting columns easier.

```r
select(fish, starts_with("radii"))
```

```
## # A tibble: 4,033 x 1
##    radii_length_mm
##              <dbl>
##  1            2.70
##  2            2.04
##  3            1.31
##  4            3.02
##  5            2.67
##  6            2.14
##  7            1.23
##  8            3.34
##  9            2.97
## 10            2.29
## # … with 4,023 more rows
```

Options to select columns based on a specific criteria include:  
1. ends_with() = Select columns that end with a character string  
2. contains() = Select columns that contain a character string  
3. matches() = Select columns that match a regular expression  
4. one_of() = Select columns names that are from a group of names  


```r
names(fish)
```

```
## [1] "lakeid"          "fish_id"         "annnumber"       "length"         
## [5] "radii_length_mm" "scalelength"
```


```r
select(fish, ends_with("id"))
```

```
## # A tibble: 4,033 x 2
##    lakeid fish_id
##    <chr>    <dbl>
##  1 AL         299
##  2 AL         299
##  3 AL         299
##  4 AL         300
##  5 AL         300
##  6 AL         300
##  7 AL         300
##  8 AL         301
##  9 AL         301
## 10 AL         301
## # … with 4,023 more rows
```

```r
select(fish, contains("fish"))
```

```
## # A tibble: 4,033 x 1
##    fish_id
##      <dbl>
##  1     299
##  2     299
##  3     299
##  4     300
##  5     300
##  6     300
##  7     300
##  8     301
##  9     301
## 10     301
## # … with 4,023 more rows
```


We won't cover [regex](https://en.wikipedia.org/wiki/Regular_expression) in this class, but the following code is helpful when you know that a column contains a letter (in this case "a") followed by a subsequent string (in this case "er").  

```r
select(fish, matches("a.+er"))
```

```
## # A tibble: 4,033 x 1
##    annnumber
##    <chr>    
##  1 EDGE     
##  2 2        
##  3 1        
##  4 EDGE     
##  5 3        
##  6 2        
##  7 1        
##  8 EDGE     
##  9 3        
## 10 2        
## # … with 4,023 more rows
```

You can also select columns based on the class of data.  

```r
glimpse(fish)
```

```
## Rows: 4,033
## Columns: 6
## $ lakeid          <chr> "AL", "AL", "AL", "AL", "AL", "AL", "AL", "AL", "AL",…
## $ fish_id         <dbl> 299, 299, 299, 300, 300, 300, 300, 301, 301, 301, 301…
## $ annnumber       <chr> "EDGE", "2", "1", "EDGE", "3", "2", "1", "EDGE", "3",…
## $ length          <dbl> 167, 167, 167, 175, 175, 175, 175, 194, 194, 194, 194…
## $ radii_length_mm <dbl> 2.697443, 2.037518, 1.311795, 3.015477, 2.670733, 2.1…
## $ scalelength     <dbl> 2.697443, 2.697443, 2.697443, 3.015477, 3.015477, 3.0…
```


```r
select_if(fish, is.numeric)
```

```
## # A tibble: 4,033 x 4
##    fish_id length radii_length_mm scalelength
##      <dbl>  <dbl>           <dbl>       <dbl>
##  1     299    167            2.70        2.70
##  2     299    167            2.04        2.70
##  3     299    167            1.31        2.70
##  4     300    175            3.02        3.02
##  5     300    175            2.67        3.02
##  6     300    175            2.14        3.02
##  7     300    175            1.23        3.02
##  8     301    194            3.34        3.34
##  9     301    194            2.97        3.34
## 10     301    194            2.29        3.34
## # … with 4,023 more rows
```

To select all columns that are *not* a class of data, you need to add a `~`.

```r
select_if(fish, ~!is.numeric(.))
```

```
## # A tibble: 4,033 x 2
##    lakeid annnumber
##    <chr>  <chr>    
##  1 AL     EDGE     
##  2 AL     2        
##  3 AL     1        
##  4 AL     EDGE     
##  5 AL     3        
##  6 AL     2        
##  7 AL     1        
##  8 AL     EDGE     
##  9 AL     3        
## 10 AL     2        
## # … with 4,023 more rows
```

## Practice  
For this exercise we will use life history data for mammals. The [data](http://esapubs.org/archive/ecol/E084/093/) are from:  
**S. K. Morgan Ernest. 2003. Life history characteristics of placental non-volant mammals. Ecology 84:3402.**  

```r
mammals <- readr::read_csv("data/mammal_lifehistories_v2.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   order = col_character(),
##   family = col_character(),
##   Genus = col_character(),
##   species = col_character(),
##   mass = col_double(),
##   gestation = col_double(),
##   newborn = col_double(),
##   weaning = col_double(),
##   `wean mass` = col_double(),
##   AFR = col_double(),
##   `max. life` = col_double(),
##   `litter size` = col_double(),
##   `litters/year` = col_double()
## )
```

1. Use one or more of your favorite functions to assess the structure of the data.  

```r
names(mammals)
```

```
##  [1] "order"        "family"       "Genus"        "species"      "mass"        
##  [6] "gestation"    "newborn"      "weaning"      "wean mass"    "AFR"         
## [11] "max. life"    "litter size"  "litters/year"
```


```r
glimpse(mammals)
```

```
## Rows: 1,440
## Columns: 13
## $ order          <chr> "Artiodactyla", "Artiodactyla", "Artiodactyla", "Artio…
## $ family         <chr> "Antilocapridae", "Bovidae", "Bovidae", "Bovidae", "Bo…
## $ Genus          <chr> "Antilocapra", "Addax", "Aepyceros", "Alcelaphus", "Am…
## $ species        <chr> "americana", "nasomaculatus", "melampus", "buselaphus"…
## $ mass           <dbl> 45375.0, 182375.0, 41480.0, 150000.0, 28500.0, 55500.0…
## $ gestation      <dbl> 8.13, 9.39, 6.35, 7.90, 6.80, 5.08, 5.72, 5.50, 8.93, …
## $ newborn        <dbl> 3246.36, 5480.00, 5093.00, 10166.67, -999.00, 3810.00,…
## $ weaning        <dbl> 3.00, 6.50, 5.63, 6.50, -999.00, 4.00, 4.04, 2.13, 10.…
## $ `wean mass`    <dbl> 8900, -999, 15900, -999, -999, -999, -999, -999, 15750…
## $ AFR            <dbl> 13.53, 27.27, 16.66, 23.02, -999.00, 14.89, 10.23, 20.…
## $ `max. life`    <dbl> 142, 308, 213, 240, -999, 251, 228, 255, 300, 324, 300…
## $ `litter size`  <dbl> 1.85, 1.00, 1.00, 1.00, 1.00, 1.37, 1.00, 1.00, 1.00, …
## $ `litters/year` <dbl> 1.00, 0.99, 0.95, -999.00, -999.00, 2.00, -999.00, 1.8…
```

2. Are there any NAs? Are you sure? Try taking an average of `max. life` as a test.  

```r
anyNA(mammals)
```

```
## [1] FALSE
```


```r
mean(mammals,"max. life")
```

```
## Warning in mean.default(mammals, "max. life"): argument is not numeric or
## logical: returning NA
```

```
## [1] NA
```


```r
x <- mammals[ 11]
x
```

```
## # A tibble: 1,440 x 1
##    `max. life`
##          <dbl>
##  1         142
##  2         308
##  3         213
##  4         240
##  5        -999
##  6         251
##  7         228
##  8         255
##  9         300
## 10         324
## # … with 1,430 more rows
```

```r
colMeans(x)
```

```
## max. life 
## -490.2556
```
-clearly, max life of mammals can't be negative, so there must be some problem
-sometimes, scientists record NAs as -999
-don't record NAs as numeric values
-just leave them blank



```r
summary(mammals)
```

```
##     order              family             Genus             species         
##  Length:1440        Length:1440        Length:1440        Length:1440       
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##       mass             gestation          newborn             weaning       
##  Min.   :     -999   Min.   :-999.00   Min.   :   -999.0   Min.   :-999.00  
##  1st Qu.:       50   1st Qu.:-999.00   1st Qu.:   -999.0   1st Qu.:-999.00  
##  Median :      403   Median :   1.05   Median :      2.6   Median :   0.73  
##  Mean   :   383577   Mean   :-287.25   Mean   :   6703.1   Mean   :-427.17  
##  3rd Qu.:     7009   3rd Qu.:   4.50   3rd Qu.:     98.0   3rd Qu.:   2.00  
##  Max.   :149000000   Max.   :  21.46   Max.   :2250000.0   Max.   :  48.00  
##    wean mass             AFR            max. life       litter size      
##  Min.   :    -999   Min.   :-999.00   Min.   :-999.0   Min.   :-999.000  
##  1st Qu.:    -999   1st Qu.:-999.00   1st Qu.:-999.0   1st Qu.:   1.000  
##  Median :    -999   Median :   2.50   Median :-999.0   Median :   2.270  
##  Mean   :   16049   Mean   :-408.12   Mean   :-490.3   Mean   : -55.634  
##  3rd Qu.:      10   3rd Qu.:  15.61   3rd Qu.: 147.2   3rd Qu.:   3.835  
##  Max.   :19075000   Max.   : 210.00   Max.   :1368.0   Max.   :  14.180  
##   litters/year     
##  Min.   :-999.000  
##  1st Qu.:-999.000  
##  Median :   0.375  
##  Mean   :-477.141  
##  3rd Qu.:   1.155  
##  Max.   :   7.500
```

3. What are the names of the columns in the `mammals` data?

```r
names(mammals)
```

```
##  [1] "order"        "family"       "Genus"        "species"      "mass"        
##  [6] "gestation"    "newborn"      "weaning"      "wean mass"    "AFR"         
## [11] "max. life"    "litter size"  "litters/year"
```

4. Rename any columns that have capital letters or punctuation issues.  

```r
mammals_new <- rename(mammals, genus="Genus", wean_mass="wean mass", max_life= "max. life", litter_size="litter size", litters_per_year="litters/year")
mammals_new
```

```
## # A tibble: 1,440 x 13
##    order family genus species   mass gestation newborn weaning wean_mass    AFR
##    <chr> <chr>  <chr> <chr>    <dbl>     <dbl>   <dbl>   <dbl>     <dbl>  <dbl>
##  1 Arti… Antil… Anti… americ… 4.54e4      8.13   3246.    3         8900   13.5
##  2 Arti… Bovid… Addax nasoma… 1.82e5      9.39   5480     6.5       -999   27.3
##  3 Arti… Bovid… Aepy… melamp… 4.15e4      6.35   5093     5.63     15900   16.7
##  4 Arti… Bovid… Alce… busela… 1.50e5      7.9   10167.    6.5       -999   23.0
##  5 Arti… Bovid… Ammo… clarkei 2.85e4      6.8    -999  -999         -999 -999  
##  6 Arti… Bovid… Ammo… lervia  5.55e4      5.08   3810     4         -999   14.9
##  7 Arti… Bovid… Anti… marsup… 3.00e4      5.72   3910     4.04      -999   10.2
##  8 Arti… Bovid… Anti… cervic… 3.75e4      5.5    3846     2.13      -999   20.1
##  9 Arti… Bovid… Bison bison   4.98e5      8.93  20000    10.7     157500   29.4
## 10 Arti… Bovid… Bison bonasus 5.00e5      9.14  23000.    6.6       -999   30.0
## # … with 1,430 more rows, and 3 more variables: max_life <dbl>,
## #   litter_size <dbl>, litters_per_year <dbl>
```

5. We are only interested in the variables `genus`, `species`, and `mass`. Use `select()` to build a new dataframe `mass` focused on these variables.

```r
mass <- select(mammals_new, "genus", "species", "mass")
mass
```

```
## # A tibble: 1,440 x 3
##    genus       species          mass
##    <chr>       <chr>           <dbl>
##  1 Antilocapra americana      45375 
##  2 Addax       nasomaculatus 182375 
##  3 Aepyceros   melampus       41480 
##  4 Alcelaphus  buselaphus    150000 
##  5 Ammodorcas  clarkei        28500 
##  6 Ammotragus  lervia         55500 
##  7 Antidorcas  marsupialis    30000 
##  8 Antilope    cervicapra     37500 
##  9 Bison       bison         497667.
## 10 Bison       bonasus       500000 
## # … with 1,430 more rows
```

-IF UNHAPPY WITH ORDER, JUST REORDER COLUMNS

```r
select(mammals_new, "species", "genus", "mass")
```

```
## # A tibble: 1,440 x 3
##    species       genus          mass
##    <chr>         <chr>         <dbl>
##  1 americana     Antilocapra  45375 
##  2 nasomaculatus Addax       182375 
##  3 melampus      Aepyceros    41480 
##  4 buselaphus    Alcelaphus  150000 
##  5 clarkei       Ammodorcas   28500 
##  6 lervia        Ammotragus   55500 
##  7 marsupialis   Antidorcas   30000 
##  8 cervicapra    Antilope     37500 
##  9 bison         Bison       497667.
## 10 bonasus       Bison       500000 
## # … with 1,430 more rows
```

6. What if we only wanted to exclude `order` and `family`? Use the `-` operator to make the code efficient.

```r
select(mammals_new, -order, -family)
```

```
## # A tibble: 1,440 x 11
##    genus species   mass gestation newborn weaning wean_mass    AFR max_life
##    <chr> <chr>    <dbl>     <dbl>   <dbl>   <dbl>     <dbl>  <dbl>    <dbl>
##  1 Anti… americ… 4.54e4      8.13   3246.    3         8900   13.5      142
##  2 Addax nasoma… 1.82e5      9.39   5480     6.5       -999   27.3      308
##  3 Aepy… melamp… 4.15e4      6.35   5093     5.63     15900   16.7      213
##  4 Alce… busela… 1.50e5      7.9   10167.    6.5       -999   23.0      240
##  5 Ammo… clarkei 2.85e4      6.8    -999  -999         -999 -999       -999
##  6 Ammo… lervia  5.55e4      5.08   3810     4         -999   14.9      251
##  7 Anti… marsup… 3.00e4      5.72   3910     4.04      -999   10.2      228
##  8 Anti… cervic… 3.75e4      5.5    3846     2.13      -999   20.1      255
##  9 Bison bison   4.98e5      8.93  20000    10.7     157500   29.4      300
## 10 Bison bonasus 5.00e5      9.14  23000.    6.6       -999   30.0      324
## # … with 1,430 more rows, and 2 more variables: litter_size <dbl>,
## #   litters_per_year <dbl>
```

7. Select the columns that include "mass" as part of the name.  

```r
select(mammals_new, contains("mass"))
```

```
## # A tibble: 1,440 x 2
##       mass wean_mass
##      <dbl>     <dbl>
##  1  45375       8900
##  2 182375       -999
##  3  41480      15900
##  4 150000       -999
##  5  28500       -999
##  6  55500       -999
##  7  30000       -999
##  8  37500       -999
##  9 497667.    157500
## 10 500000       -999
## # … with 1,430 more rows
```

8. Select all of the columns that are of class `character`.  

```r
select_if(mammals_new, ~is.character(.))
```

```
## # A tibble: 1,440 x 4
##    order        family         genus       species      
##    <chr>        <chr>          <chr>       <chr>        
##  1 Artiodactyla Antilocapridae Antilocapra americana    
##  2 Artiodactyla Bovidae        Addax       nasomaculatus
##  3 Artiodactyla Bovidae        Aepyceros   melampus     
##  4 Artiodactyla Bovidae        Alcelaphus  buselaphus   
##  5 Artiodactyla Bovidae        Ammodorcas  clarkei      
##  6 Artiodactyla Bovidae        Ammotragus  lervia       
##  7 Artiodactyla Bovidae        Antidorcas  marsupialis  
##  8 Artiodactyla Bovidae        Antilope    cervicapra   
##  9 Artiodactyla Bovidae        Bison       bison        
## 10 Artiodactyla Bovidae        Bison       bonasus      
## # … with 1,430 more rows
```

## Other
Here are two examples of code that are super helpful to have in your bag of tricks.  

Imported data frames often have a mix of lower and uppercase column names. Use `toupper()` or `tolower()` to fix this issue. I always try to use lowercase to keep things consistent.  

```r
mammals <- select_all(mammals, tolower)
mammals
```

```
## # A tibble: 1,440 x 13
##    order family genus species   mass gestation newborn weaning `wean mass`
##    <chr> <chr>  <chr> <chr>    <dbl>     <dbl>   <dbl>   <dbl>       <dbl>
##  1 Arti… Antil… Anti… americ… 4.54e4      8.13   3246.    3           8900
##  2 Arti… Bovid… Addax nasoma… 1.82e5      9.39   5480     6.5         -999
##  3 Arti… Bovid… Aepy… melamp… 4.15e4      6.35   5093     5.63       15900
##  4 Arti… Bovid… Alce… busela… 1.50e5      7.9   10167.    6.5         -999
##  5 Arti… Bovid… Ammo… clarkei 2.85e4      6.8    -999  -999           -999
##  6 Arti… Bovid… Ammo… lervia  5.55e4      5.08   3810     4           -999
##  7 Arti… Bovid… Anti… marsup… 3.00e4      5.72   3910     4.04        -999
##  8 Arti… Bovid… Anti… cervic… 3.75e4      5.5    3846     2.13        -999
##  9 Arti… Bovid… Bison bison   4.98e5      8.93  20000    10.7       157500
## 10 Arti… Bovid… Bison bonasus 5.00e5      9.14  23000.    6.6         -999
## # … with 1,430 more rows, and 4 more variables: afr <dbl>, `max. life` <dbl>,
## #   `litter size` <dbl>, `litters/year` <dbl>
```


```r
names(mammals)
```

```
##  [1] "order"        "family"       "genus"        "species"      "mass"        
##  [6] "gestation"    "newborn"      "weaning"      "wean mass"    "afr"         
## [11] "max. life"    "litter size"  "litters/year"
```

When naming columns, blank spaces are often added (don't do this, please). Here is a trick to remove these.  

```r
select_all(mammals, ~str_replace(., " ", "_"))
```

```
## # A tibble: 1,440 x 13
##    order family genus species   mass gestation newborn weaning wean_mass    afr
##    <chr> <chr>  <chr> <chr>    <dbl>     <dbl>   <dbl>   <dbl>     <dbl>  <dbl>
##  1 Arti… Antil… Anti… americ… 4.54e4      8.13   3246.    3         8900   13.5
##  2 Arti… Bovid… Addax nasoma… 1.82e5      9.39   5480     6.5       -999   27.3
##  3 Arti… Bovid… Aepy… melamp… 4.15e4      6.35   5093     5.63     15900   16.7
##  4 Arti… Bovid… Alce… busela… 1.50e5      7.9   10167.    6.5       -999   23.0
##  5 Arti… Bovid… Ammo… clarkei 2.85e4      6.8    -999  -999         -999 -999  
##  6 Arti… Bovid… Ammo… lervia  5.55e4      5.08   3810     4         -999   14.9
##  7 Arti… Bovid… Anti… marsup… 3.00e4      5.72   3910     4.04      -999   10.2
##  8 Arti… Bovid… Anti… cervic… 3.75e4      5.5    3846     2.13      -999   20.1
##  9 Arti… Bovid… Bison bison   4.98e5      8.93  20000    10.7     157500   29.4
## 10 Arti… Bovid… Bison bonasus 5.00e5      9.14  23000.    6.6       -999   30.0
## # … with 1,430 more rows, and 3 more variables: max._life <dbl>,
## #   litter_size <dbl>, `litters/year` <dbl>
```


~ means search across all the data frames

## That's it! Take a break and I will see you on Zoom!  

-->[Home](https://jmledford3115.github.io/datascibiol/)  

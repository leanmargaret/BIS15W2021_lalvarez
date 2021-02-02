---
title: "Midterm 1"
author: "Lean Alvarez"
date: "2021-02-02"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your code should be organized, clean, and run free from errors. Be sure to **add your name** to the author header above. You may use any resources to answer these questions (including each other), but you may not post questions to Open Stacks or external help sites. There are 12 total questions.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

This exam is due by **12:00p on Thursday, January 28**.  

## Load the tidyverse
If you plan to use any other libraries to complete this assignment then you should load them here.

```r
library(tidyverse)
library(janitor)
```

## Questions
**1. (2 points) Briefly explain how R, RStudio, and GitHub work together to make work flows in data science transparent and repeatable. What is the advantage of using RMarkdown in this context?**  
R and RStudio allows us develop codes that help us organize and analyze our data. GitHub allows us to share our work from R and RStudio to others so they are able to see what we did, allowing them to replicate our work and make improvements. RMarkdown is useful because it can create outputs of our work that others are able to see easily, such as an md file, and others can see our step-by-step processes and easily make improvements on our work by simply accessing the same RMarkdown as us.

**2. (2 points) What are the three types of `data structures` that we have discussed? Why are we using data frames for BIS 15L?**
We have used vectors, matrices, and data frames. We are using data frames for BIS15L because they are used the most by others(so we can be familiar with other people's work), and data frames allow us to have as much data of any kind put together all in one place.


In the midterm 1 folder there is a second folder called `data`. Inside the `data` folder, there is a .csv file called `ElephantsMF`. These data are from Phyllis Lee, Stirling University, and are related to Lee, P., et al. (2013), "Enduring consequences of early experiences: 40-year effects on survival and success among African elephants (Loxodonta africana)," Biology Letters, 9: 20130011. [kaggle](https://www.kaggle.com/mostafaelseidy/elephantsmf).  

**3. (2 points) Please load these data as a new object called `elephants`. Use the function(s) of your choice to get an idea of the structure of the data. Be sure to show the class of each variable.**

```r
elephants <- readr::read_csv("data/ElephantsMF.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   Age = col_double(),
##   Height = col_double(),
##   Sex = col_character()
## )
```

```r
summary(elephants)
```

```
##       Age            Height           Sex           
##  Min.   : 0.01   Min.   : 75.46   Length:288        
##  1st Qu.: 4.58   1st Qu.:160.75   Class :character  
##  Median : 9.46   Median :200.00   Mode  :character  
##  Mean   :10.97   Mean   :187.68                     
##  3rd Qu.:16.50   3rd Qu.:221.09                     
##  Max.   :32.17   Max.   :304.06
```

```r
glimpse(elephants)
```

```
## Rows: 288
## Columns: 3
## $ Age    <dbl> 1.40, 17.50, 12.75, 11.17, 12.67, 12.67, 12.25, 12.17, 28.17...
## $ Height <dbl> 120.00, 227.00, 235.00, 210.00, 220.00, 189.00, 225.00, 204....
## $ Sex    <chr> "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", ...
```

```r
class("age")
```

```
## [1] "character"
```

```r
class("height")
```

```
## [1] "character"
```

```r
class("sex")
```

```
## [1] "character"
```




**4. (2 points) Change the names of the variables to lower case and change the class of the variable `sex` to a factor.**

```r
elephants <- janitor::clean_names(elephants)
elephants$sex <- as.factor(elephants$sex)
```




**5. (2 points) How many male and female elephants are represented in the data?**

```r
elephants %>% 
  count(sex)
```

```
## # A tibble: 2 x 2
##   sex       n
## * <fct> <int>
## 1 F       150
## 2 M       138
```
There are 150 female elephants and 138 male elephants in the data.

**6. (2 points) What is the average age of all elephants in the data?**

```r
elephants %>% 
  summarise(mean_age_elephants=mean(age))
```

```
## # A tibble: 1 x 1
##   mean_age_elephants
##                <dbl>
## 1               11.0
```
The average age of all elephants in the data is about 11 years old.

**7. (2 points) How does the average age and height of elephants compare by sex?**

```r
elephants %>% 
  group_by(sex) %>% 
  summarize(mean_age=mean(age), 
            mean_height=mean(height))
```

```
## # A tibble: 2 x 3
##   sex   mean_age mean_height
## * <fct>    <dbl>       <dbl>
## 1 F        12.8         190.
## 2 M         8.95        185.
```
On average, females are older and taller than males.


**8. (2 points) How does the average height of elephants compare by sex for individuals over 25 years old. Include the min and max height as well as the number of individuals in the sample as part of your analysis.**


```r
elephants %>% 
  group_by(sex) %>% 
  filter(age>25) %>% 
  summarize(min_height_M=min(height), 
            max_height_M=max(height), 
            mean_height_M=mean(height),
            n=n())
```

```
## # A tibble: 2 x 5
##   sex   min_height_M max_height_M mean_height_M     n
##   <fct>        <dbl>        <dbl>         <dbl> <int>
## 1 F             206.         278.          233.    25
## 2 M             237.         304.          273.     8
```
For individuals over 25 years old, males have a higher minimum, maximum, and mean height. However, since there are only 8 samples for males compared to the 25 samples for females, this would likely change when more samples are added.



For the next series of questions, we will use data from a study on vertebrate community composition and impacts from defaunation in [Gabon, Africa](https://en.wikipedia.org/wiki/Gabon). One thing to notice is that the data include 24 separate transects. Each transect represents a path through different forest management areas.  

Reference: Koerner SE, Poulsen JR, Blanchard EJ, Okouyi J, Clark CJ. Vertebrate community composition and diversity declines along a defaunation gradient radiating from rural villages in Gabon. _Journal of Applied Ecology_. 2016. This paper, along with a description of the variables is included inside the midterm 1 folder.  

**9. (2 points) Load `IvindoData_DryadVersion.csv` and use the function(s) of your choice to get an idea of the overall structure. Change the variables `HuntCat` and `LandUse` to factors.**

```r
gabon <- readr::read_csv("data/IvindoData_DryadVersion.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_double(),
##   HuntCat = col_character(),
##   LandUse = col_character()
## )
## i Use `spec()` for the full column specifications.
```

```r
gabon <- janitor::clean_names(gabon)
gabon$hunt_cat <- as.factor(gabon$hunt_cat)
gabon$land_use <- as.factor(gabon$land_use)
```



```r
summary(gabon)
```

```
##   transect_id       distance          hunt_cat num_households     land_use 
##  Min.   : 1.00   Min.   : 2.700   High    :7   Min.   :13.00   Logging:13  
##  1st Qu.: 5.75   1st Qu.: 5.668   Moderate:8   1st Qu.:24.75   Neither: 4  
##  Median :14.50   Median : 9.720   None    :9   Median :29.00   Park   : 7  
##  Mean   :13.50   Mean   :11.879                Mean   :37.88               
##  3rd Qu.:20.25   3rd Qu.:17.683                3rd Qu.:54.00               
##  Max.   :27.00   Max.   :26.760                Max.   :73.00               
##     veg_rich       veg_stems       veg_liana         veg_dbh     
##  Min.   :10.88   Min.   :23.44   Min.   : 4.750   Min.   :28.45  
##  1st Qu.:13.10   1st Qu.:28.69   1st Qu.: 9.033   1st Qu.:40.65  
##  Median :14.94   Median :32.45   Median :11.940   Median :43.90  
##  Mean   :14.83   Mean   :32.80   Mean   :11.040   Mean   :46.09  
##  3rd Qu.:16.54   3rd Qu.:37.08   3rd Qu.:13.250   3rd Qu.:50.58  
##  Max.   :18.75   Max.   :47.56   Max.   :16.380   Max.   :76.48  
##    veg_canopy    veg_understory     ra_apes          ra_birds    
##  Min.   :2.500   Min.   :2.380   Min.   : 0.000   Min.   :31.56  
##  1st Qu.:3.250   1st Qu.:2.875   1st Qu.: 0.000   1st Qu.:52.51  
##  Median :3.430   Median :3.000   Median : 0.485   Median :57.90  
##  Mean   :3.469   Mean   :3.020   Mean   : 2.045   Mean   :58.64  
##  3rd Qu.:3.750   3rd Qu.:3.167   3rd Qu.: 3.815   3rd Qu.:68.17  
##  Max.   :4.000   Max.   :3.880   Max.   :12.930   Max.   :85.03  
##   ra_elephant       ra_monkeys      ra_rodent      ra_ungulate    
##  Min.   :0.0000   Min.   : 5.84   Min.   :1.060   Min.   : 0.000  
##  1st Qu.:0.0000   1st Qu.:22.70   1st Qu.:2.047   1st Qu.: 1.232  
##  Median :0.3600   Median :31.74   Median :3.230   Median : 2.545  
##  Mean   :0.5450   Mean   :31.30   Mean   :3.278   Mean   : 4.166  
##  3rd Qu.:0.8925   3rd Qu.:39.88   3rd Qu.:4.093   3rd Qu.: 5.157  
##  Max.   :2.3000   Max.   :54.12   Max.   :6.310   Max.   :13.860  
##  rich_all_species evenness_all_species diversity_all_species rich_bird_species
##  Min.   :15.00    Min.   :0.6680       Min.   :1.966         Min.   : 8.00    
##  1st Qu.:19.00    1st Qu.:0.7542       1st Qu.:2.248         1st Qu.:10.00    
##  Median :20.00    Median :0.7760       Median :2.316         Median :11.00    
##  Mean   :20.21    Mean   :0.7699       Mean   :2.310         Mean   :10.33    
##  3rd Qu.:22.00    3rd Qu.:0.8083       3rd Qu.:2.429         3rd Qu.:11.00    
##  Max.   :24.00    Max.   :0.8330       Max.   :2.566         Max.   :13.00    
##  evenness_bird_species diversity_bird_species rich_mammal_species
##  Min.   :0.5590        Min.   :1.162          Min.   : 6.000     
##  1st Qu.:0.6825        1st Qu.:1.603          1st Qu.: 9.000     
##  Median :0.7220        Median :1.680          Median :10.000     
##  Mean   :0.7137        Mean   :1.661          Mean   : 9.875     
##  3rd Qu.:0.7722        3rd Qu.:1.784          3rd Qu.:11.000     
##  Max.   :0.8240        Max.   :2.008          Max.   :12.000     
##  evenness_mammal_species diversity_mammal_species
##  Min.   :0.6190          Min.   :1.378           
##  1st Qu.:0.7073          1st Qu.:1.567           
##  Median :0.7390          Median :1.699           
##  Mean   :0.7477          Mean   :1.698           
##  3rd Qu.:0.7847          3rd Qu.:1.815           
##  Max.   :0.8610          Max.   :2.065
```


```r
glimpse(gabon)
```

```
## Rows: 24
## Columns: 26
## $ transect_id              <dbl> 1, 2, 2, 3, 4, 5, 6, 7, 8, 9, 13, 14, 15, ...
## $ distance                 <dbl> 7.14, 17.31, 18.32, 20.85, 15.95, 17.47, 2...
## $ hunt_cat                 <fct> Moderate, None, None, None, None, None, No...
## $ num_households           <dbl> 54, 54, 29, 29, 29, 29, 29, 54, 25, 73, 46...
## $ land_use                 <fct> Park, Park, Park, Logging, Park, Park, Par...
## $ veg_rich                 <dbl> 16.67, 15.75, 16.88, 12.44, 17.13, 16.50, ...
## $ veg_stems                <dbl> 31.20, 37.44, 32.33, 29.39, 36.00, 29.22, ...
## $ veg_liana                <dbl> 5.78, 13.25, 4.75, 9.78, 13.25, 12.88, 8.3...
## $ veg_dbh                  <dbl> 49.57, 34.59, 42.82, 36.62, 41.52, 44.07, ...
## $ veg_canopy               <dbl> 3.78, 3.75, 3.43, 3.75, 3.88, 2.50, 4.00, ...
## $ veg_understory           <dbl> 2.89, 3.88, 3.00, 2.75, 3.25, 3.00, 2.38, ...
## $ ra_apes                  <dbl> 1.87, 0.00, 4.49, 12.93, 0.00, 2.48, 3.78,...
## $ ra_birds                 <dbl> 52.66, 52.17, 37.44, 59.29, 52.62, 38.64, ...
## $ ra_elephant              <dbl> 0.00, 0.86, 1.33, 0.56, 1.00, 0.00, 1.11, ...
## $ ra_monkeys               <dbl> 38.59, 28.53, 41.82, 19.85, 41.34, 43.29, ...
## $ ra_rodent                <dbl> 4.22, 6.04, 1.06, 3.66, 2.52, 1.83, 3.10, ...
## $ ra_ungulate              <dbl> 2.66, 12.41, 13.86, 3.71, 2.53, 13.75, 3.1...
## $ rich_all_species         <dbl> 22, 20, 22, 19, 20, 22, 23, 19, 19, 19, 21...
## $ evenness_all_species     <dbl> 0.793, 0.773, 0.740, 0.681, 0.811, 0.786, ...
## $ diversity_all_species    <dbl> 2.452, 2.314, 2.288, 2.006, 2.431, 2.429, ...
## $ rich_bird_species        <dbl> 11, 10, 11, 8, 8, 10, 11, 11, 11, 9, 11, 1...
## $ evenness_bird_species    <dbl> 0.732, 0.704, 0.688, 0.559, 0.799, 0.771, ...
## $ diversity_bird_species   <dbl> 1.756, 1.620, 1.649, 1.162, 1.660, 1.775, ...
## $ rich_mammal_species      <dbl> 11, 10, 11, 11, 12, 12, 12, 8, 8, 10, 10, ...
## $ evenness_mammal_species  <dbl> 0.736, 0.705, 0.650, 0.619, 0.736, 0.694, ...
## $ diversity_mammal_species <dbl> 1.764, 1.624, 1.558, 1.484, 1.829, 1.725, ...
```



**10. (4 points) For the transects with high and moderate hunting intensity, how does the average diversity of birds and mammals compare?**


```r
gabon %>% 
  group_by(hunt_cat) %>% 
  filter(hunt_cat=="Moderate" | hunt_cat=="High") %>% 
  summarize(avg_div_birds=mean(diversity_bird_species), 
            avg_div_mammals=mean(diversity_mammal_species))
```

```
## # A tibble: 2 x 3
##   hunt_cat avg_div_birds avg_div_mammals
##   <fct>            <dbl>           <dbl>
## 1 High              1.66            1.74
## 2 Moderate          1.62            1.68
```
Transects with high hunting intensity have a higher average diversity of both birds and mammals than transects with moderate hunting intensity.



**11. (4 points) One of the conclusions in the study is that the relative abundance of animals drops off the closer you get to a village. Let's try to reconstruct this (without the statistics). How does the relative abundance (RA) of apes, birds, elephants, monkeys, rodents, and ungulates compare between sites that are less than 5km from a village to sites that are greater than 20km from a village? The variable `Distance` measures the distance of the transect from the nearest village. Hint: try using the `across` operator.**  

```r
far <- gabon %>% 
  filter(distance>20) %>% 
  summarize(across(contains("ra_"), mean, na.rm=T))
far
```

```
## # A tibble: 1 x 6
##   ra_apes ra_birds ra_elephant ra_monkeys ra_rodent ra_ungulate
##     <dbl>    <dbl>       <dbl>      <dbl>     <dbl>       <dbl>
## 1    7.21     44.5       0.557       40.1      2.68        4.98
```

```r
near <- gabon %>% 
  filter(distance<5) %>% 
  summarize(across(contains("ra_"), mean, na.rm=T))
near
```

```
## # A tibble: 1 x 6
##   ra_apes ra_birds ra_elephant ra_monkeys ra_rodent ra_ungulate
##     <dbl>    <dbl>       <dbl>      <dbl>     <dbl>       <dbl>
## 1    0.08     70.4      0.0967       24.1      3.66        1.59
```
For apes, elephants, monkeys, and ungulates, their relative abundances are higher when they are more than 20 km away from a village. This might be because larger animals would tend to live away from humans because they might be hunted by humans or there is not enough space for them to live close to humans. For birds and rodents, their relative abundances are lower when they are less than 5 km away from a village. Perhaps this is because birds can fly, so they can easily travel back and forth and live in the trees where humans are not also living in. As for rodents, it might be because they are quite small in size, so they are able to live with humans.



**12. (4 points) Based on your interest, do one exploratory analysis on the `gabon` data of your choice. This analysis needs to include a minimum of two functions in `dplyr.`**

```r
gabon %>% 
  filter(hunt_cat=="None") %>% 
  summarize(avg_rich_birds=mean(rich_bird_species), 
            avg_rich_mammals=mean(rich_mammal_species))
```

```
## # A tibble: 1 x 2
##   avg_rich_birds avg_rich_mammals
##            <dbl>            <dbl>
## 1           10.2             10.8
```
When their transects have no hunting intensity, mammals have a higher species richness than birds. 


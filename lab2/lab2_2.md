---
title: "Data Structures: Vectors and Data Matrices"
date: "2021-01-08"
output:
  html_document: 
    theme: spacelab
    toc: yes
    toc_float: yes
    keep_md: yes
  pdf_document:
    toc: yes
---

## Breakout Rooms  
Please take 5-8 minutes to check over your answers to HW 1 in your group. If you are stuck, please remember that you can check the key in [Joel's repository](https://github.com/jmledford3115/BIS15LW2021_jledford).  

## Learning Goals
*At the end of this exercise, you will be able to:*    
1. Define data structures and provide examples of vectors and data matrices.  
2. Build a new vector and call elements within it.  
3. Combine a series of vectors into a data matrix.  
4. Name columns and rows in a data matrix.  
5. Select values and use summary functions in a data matrix.  

## Data Structures
In addition to classes of data, R also organizes data in different ways. These are called data structures and include vectors, lists, matrices, data frames, and factors. For now, we will focus on `vectors`.  

## Vectors
Vectors are a common way of organizing data in R.  We create vectors using the `c` command. The `c` stands for concatenate.  

A numeric vector.

```r
my_vector <- c(10, 20, 30)
is.numeric(my_vector)
```

```
## [1] TRUE
```

A character vector. Characters always have quotes and may be referred to as "strings".

```r
days_of_the_week <- c("Monday", "Tuesday", "Wednesday", "Thrusday", "Friday", "Saturday", "Sunday")
days_of_the_week
```

```
## [1] "Monday"    "Tuesday"   "Wednesday" "Thrusday"  "Friday"    "Saturday" 
## [7] "Sunday"
```


```r
is.numeric(days_of_the_week)
```

```
## [1] FALSE
```

A convenient trick for creating a vector is to generate a sequence of numbers.

```r
my_vector_sequence <- c(1:100, seq=0.5)
my_vector_sequence
```

```
##                                                                               
##   1.0   2.0   3.0   4.0   5.0   6.0   7.0   8.0   9.0  10.0  11.0  12.0  13.0 
##                                                                               
##  14.0  15.0  16.0  17.0  18.0  19.0  20.0  21.0  22.0  23.0  24.0  25.0  26.0 
##                                                                               
##  27.0  28.0  29.0  30.0  31.0  32.0  33.0  34.0  35.0  36.0  37.0  38.0  39.0 
##                                                                               
##  40.0  41.0  42.0  43.0  44.0  45.0  46.0  47.0  48.0  49.0  50.0  51.0  52.0 
##                                                                               
##  53.0  54.0  55.0  56.0  57.0  58.0  59.0  60.0  61.0  62.0  63.0  64.0  65.0 
##                                                                               
##  66.0  67.0  68.0  69.0  70.0  71.0  72.0  73.0  74.0  75.0  76.0  77.0  78.0 
##                                                                               
##  79.0  80.0  81.0  82.0  83.0  84.0  85.0  86.0  87.0  88.0  89.0  90.0  91.0 
##                                                         seq 
##  92.0  93.0  94.0  95.0  96.0  97.0  98.0  99.0 100.0   0.5
```

## Identifying vector elements
We can use `[]` to pull out elements in a vector. We just need to specify their position in the vector; i.e. day 3 is Wednesday.

```r
days_of_the_week[8]
```

```
## [1] NA
```

```r
days_of_the_week[3]
```

```
## [1] "Wednesday"
```

## Practice
Work through these examples and make adjustments to the values to experiment.

2. Evaluate all numerics in `my_vector_sequence` to determine which has a value of 15.  

```r
 my_vector_sequence==15
```

```
##                                                                               
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE 
##                                                                               
## FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE 
##                                                                               
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE 
##                                                                               
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE 
##                                                                               
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE 
##                                                                               
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE 
##                                                                               
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE 
##                                                         seq 
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
```



3. We can use operators such as <, >, ==, <==, etc. Show all values in `my_vector_sequence` that are less than 10.  How about less than or equal to 10?  

```r
my_vector_sequence < 10
```

```
##                                                                               
##  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE 
##                                                                               
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE 
##                                                                               
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE 
##                                                                               
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE 
##                                                                               
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE 
##                                                                               
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE 
##                                                                               
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE 
##                                                         seq 
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
```


```r
my_vector_sequence <= 10
```

```
##                                                                               
##  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE 
##                                                                               
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE 
##                                                                               
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE 
##                                                                               
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE 
##                                                                               
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE 
##                                                                               
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE 
##                                                                               
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE 
##                                                         seq 
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
```

4. If you use `[]` then you only get the values, not the logical evaluation of the entire vector. Experiment with this by adjusting the chunk below.    

```r
yet_another_new_vector <- my_vector_sequence[my_vector_sequence <= 15]
```

## Data Matrices
Data matrices are a series of stacked vectors, similar to a data table. In the example below, we build a new data matrix using the matrix command.  

Box office earnings for Harry Potter movies (in millions!). Notice that these are separate vectors.  

```r
Philosophers_Stone <- c(317.5, 657.1)
Chamber_of_Secrets <- c(261.9, 616.9)
Prisoner_of_Azkaban <- c(249.5, 547.1)
Goblet_of_Fire <- c(290.0, 606.8)
Order_of_the_Phoenix <- c(292.0, 647.8)
Half_Blood_Prince <- c(301.9, 632.4)
Deathly_Hallows_1 <- c(295.9, 664.3)
Deathly_Hallows_2 <- c(381.0, 960.5)
```

Create a new object called `box_office`. Here we are using the `c` command to combine the vectors into one.

```r
box_office <- c(Philosophers_Stone, Chamber_of_Secrets, Prisoner_of_Azkaban, Goblet_of_Fire, Order_of_the_Phoenix, Half_Blood_Prince, Deathly_Hallows_1, Deathly_Hallows_2)
box_office
```

```
##  [1] 317.5 657.1 261.9 616.9 249.5 547.1 290.0 606.8 292.0 647.8 301.9 632.4
## [13] 295.9 664.3 381.0 960.5
```

Create `harry_potter_matrix` using the `matrix()` command. We need to tell R how to organize the `box_office` vector using the `nrow` and `byrow` commands.

```r
harry_potter_matrix <- matrix(box_office, nrow = 8, byrow = T)
harry_potter_matrix
```

```
##       [,1]  [,2]
## [1,] 317.5 657.1
## [2,] 261.9 616.9
## [3,] 249.5 547.1
## [4,] 290.0 606.8
## [5,] 292.0 647.8
## [6,] 301.9 632.4
## [7,] 295.9 664.3
## [8,] 381.0 960.5
```
## Name the rows and columns
Vectors `region` and `titles`, used for naming.

```r
region <- c("US", "non-US")
region
```

```
## [1] "US"     "non-US"
```


```r
titles <- c("Philosophers_Stone", "Chamber_of_Secrets", "Prisoner_of_Azkaban", "Goblet_of_Fire", "Order_of_the_Phoenix", "Half_Blood_Prince", "Deathly_Hallows_1", "Deathly_Hallows_2")
titles
```

```
## [1] "Philosophers_Stone"   "Chamber_of_Secrets"   "Prisoner_of_Azkaban" 
## [4] "Goblet_of_Fire"       "Order_of_the_Phoenix" "Half_Blood_Prince"   
## [7] "Deathly_Hallows_1"    "Deathly_Hallows_2"
```

Name the columns using `colnames()` with the vector region.

```r
colnames(harry_potter_matrix) <- region
```

Name the rows using `rownames()` with the vector titles.

```r
rownames(harry_potter_matrix) <- titles
```

Print `harry_potter_matrix`.

```r
harry_potter_matrix
```

```
##                         US non-US
## Philosophers_Stone   317.5  657.1
## Chamber_of_Secrets   261.9  616.9
## Prisoner_of_Azkaban  249.5  547.1
## Goblet_of_Fire       290.0  606.8
## Order_of_the_Phoenix 292.0  647.8
## Half_Blood_Prince    301.9  632.4
## Deathly_Hallows_1    295.9  664.3
## Deathly_Hallows_2    381.0  960.5
```

## Using a data matrix
Once you have a data matrix, you can perform lots of different analyses. For example, you can calculate the total earnings of each movie.

```r
global <- rowSums(harry_potter_matrix)
global
```

```
##   Philosophers_Stone   Chamber_of_Secrets  Prisoner_of_Azkaban 
##                974.6                878.8                796.6 
##       Goblet_of_Fire Order_of_the_Phoenix    Half_Blood_Prince 
##                896.8                939.8                934.3 
##    Deathly_Hallows_1    Deathly_Hallows_2 
##                960.2               1341.5
```

And even add a new column to reflect this calculation. `cbind()` adds columns.

```r
all_harry_potter_matrix <- cbind(harry_potter_matrix, global)
all_harry_potter_matrix
```

```
##                         US non-US global
## Philosophers_Stone   317.5  657.1  974.6
## Chamber_of_Secrets   261.9  616.9  878.8
## Prisoner_of_Azkaban  249.5  547.1  796.6
## Goblet_of_Fire       290.0  606.8  896.8
## Order_of_the_Phoenix 292.0  647.8  939.8
## Half_Blood_Prince    301.9  632.4  934.3
## Deathly_Hallows_1    295.9  664.3  960.2
## Deathly_Hallows_2    381.0  960.5 1341.5
```


```r
Deathy_Hallow_3 <- c(38.0, 96.5)
```

```r
all_harry_potter_matrix <- rbind(all_harry_potter_matrix, global, Deathy_Hallow_3)
```

```
## Warning in rbind(all_harry_potter_matrix, global, Deathy_Hallow_3): number of
## columns of result is not a multiple of vector length (arg 2)
```

```r
all_harry_potter_matrix
```

```
##                         US non-US global
## Philosophers_Stone   317.5  657.1  974.6
## Chamber_of_Secrets   261.9  616.9  878.8
## Prisoner_of_Azkaban  249.5  547.1  796.6
## Goblet_of_Fire       290.0  606.8  896.8
## Order_of_the_Phoenix 292.0  647.8  939.8
## Half_Blood_Prince    301.9  632.4  934.3
## Deathly_Hallows_1    295.9  664.3  960.2
## Deathly_Hallows_2    381.0  960.5 1341.5
## global               974.6  878.8  796.6
## Deathy_Hallow_3       38.0   96.5   38.0
```

## Practice
1. What are the total earnings for the US and non-US regions?  

```r
total_earnings <- colSums(harry_potter_matrix)
total_earnings
```

```
##     US non-US 
## 2389.7 5332.9
```


2. Add this information to the data matrix. Hint: you are adding a row, not a column.  

```r
final_harry_potter_matrix <- rbind(all_harry_potter_matrix, total_earnings)
```

```
## Warning in rbind(all_harry_potter_matrix, total_earnings): number of columns of
## result is not a multiple of vector length (arg 2)
```

```r
final_harry_potter_matrix
```

```
##                          US non-US global
## Philosophers_Stone    317.5  657.1  974.6
## Chamber_of_Secrets    261.9  616.9  878.8
## Prisoner_of_Azkaban   249.5  547.1  796.6
## Goblet_of_Fire        290.0  606.8  896.8
## Order_of_the_Phoenix  292.0  647.8  939.8
## Half_Blood_Prince     301.9  632.4  934.3
## Deathly_Hallows_1     295.9  664.3  960.2
## Deathly_Hallows_2     381.0  960.5 1341.5
## global                974.6  878.8  796.6
## Deathy_Hallow_3        38.0   96.5   38.0
## total_earnings       2389.7 5332.9 2389.7
```

## A few Extras
The same methods of selecting elements in a vector apply to data matrices. We use `[]`. The following selects the value in the first column, second row.

```r
harry_potter_matrix[2,1]
```

```
## [1] 261.9
```

Adding a colon `:` selects the specified elements in a column.  

```r
harry_potter_matrix[1:4]
```

```
## [1] 317.5 261.9 249.5 290.0
```

We can also select values in an entire row or column. This can be useful for calculations. Here we calculate the mean of the entire second column. 

```r
non_us_earnings <- all_harry_potter_matrix[ ,2]
mean(non_us_earnings)
```

```
## [1] 630.82
```


```r
non_us_earnings <- all_harry_potter_matrix[ ,2]
mean(non_us_earnings)
```

```
## [1] 630.82
```

fourth column, first row [4 ,1]
## Wrap-up
Please review the learning goals and be sure to use the code here as a reference when completing the homework.  
-->[Home](https://jmledford3115.github.io/datascibiol/)

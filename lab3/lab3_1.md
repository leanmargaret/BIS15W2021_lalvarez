---
title: "Data Frames"
date: "2021-01-12"
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
1. Combine a series of vectors into a data frame.  
2. Name columns and rows in a data frame.  
3. Select columns and rows and use summary functions.   
4. Change data classes of columns in the data frame.  
5. Write your data frame to a csv file!  

## Load tidyverse

```r
library("tidyverse")
```

## Data Frames
During lab 2, you learned how to work with vectors and data matrices. Today we will organize the vectors into a new type of data structure called a **data frame**. The data frame is the most common way to organize data within R. You can think of a data frame as similar to a spreadsheet. A data frame can store data of many different classes.  

Let's build separate vectors that include length (in), weight (oz), and sex of three [ruby-throated hummingbirds](https://www.audubon.org/field-guide/bird/ruby-throated-hummingbird).  

```r
Sex <- c("Male", "Female", "Male")
Length <- c(3.2, 3.7, 3.4)
Weight <- c(2.9, 4.0, 3.1)
```

Here we combine our three vectors to create a data frame with the function `data.frame()`.

```r
hbirds <- data.frame(Sex, Length, Weight)
hbirds
```

```
##      Sex Length Weight
## 1   Male    3.2    2.9
## 2 Female    3.7    4.0
## 3   Male    3.4    3.1
```

OK, stop and think- how does this differ from making a data matrix? Are the data treated differently?  

```r
hummingbirds <- c(Sex, Length, Weight)
hummingbirds_matrix <- matrix(hummingbirds, nrow=3, byrow = T)
hummingbirds_matrix
```

```
##      [,1]   [,2]     [,3]  
## [1,] "Male" "Female" "Male"
## [2,] "3.2"  "3.7"    "3.4" 
## [3,] "2.9"  "4"      "3.1"
```

Notice that not only are the data neat and clean looking, there is also information provided about the class of data. `dbl` means that the value is a type of numeric [double precision floating point](http://uc-r.github.io/integer_double/). 

What are the column names of our data frame? Notice that R defaulted to using the names of our vectors, but we could name them something else when creating the data frame, or rename them later.

```r
names(hbirds)
```

```
## [1] "Sex"    "Length" "Weight"
```

What are the dimensions of the `hbirds` data frame? The `dim()` and `str()` commands provide this information.   

```r
dim(hbirds)
```

```
## [1] 3 3
```


```r
str(hbirds)
```

```
## 'data.frame':	3 obs. of  3 variables:
##  $ Sex   : chr  "Male" "Female" "Male"
##  $ Length: num  3.2 3.7 3.4
##  $ Weight: num  2.9 4 3.1
```

Let's use lowercase names when we create the data frame. We just changed to lowercase here, but we could use any names we wish.  

```r
hbirds <- data.frame(sex = Sex, length_in = Length, weight_oz = Weight) #renaming will become more helpful in later labs
names(hbirds)
```

```
## [1] "sex"       "length_in" "weight_oz"
```


```r
hbirds
```

```
##      sex length_in weight_oz
## 1   Male       3.2       2.9
## 2 Female       3.7       4.0
## 3   Male       3.4       3.1
```

## Accessing Data Frame Columns and Rows 
The same methods of selecting elements in vectors and data matrices apply to data frames. We use `[]`. We have two positions where the first applies to the rows, and the second to the columns.  

The first row.  

```r
hbirds[1,]
```

```
##    sex length_in weight_oz
## 1 Male       3.2       2.9
```

The third column.  

```r
hbirds[ ,3]
```

```
## [1] 2.9 4.0 3.1
```

We can also select values in an entire column using the `$` sign. This can be useful for calculations. Here we calculate the mean of all of the birds weights. 

```r
w <- hbirds$weight_oz 
```


```r
mean(w)
```

```
## [1] 3.333333
```

## Adding Rows
We can add a new bird's data with the `rbind()` function, known as row bind. It will bind our new vector to our data frame row-wise.

```r
new_bird <- c("Female", 3.6, 3.9)
new_bird
```

```
## [1] "Female" "3.6"    "3.9"
```


```r
hbirds<- rbind(hbirds, new_bird)
hbirds
```

```
##      sex length_in weight_oz
## 1   Male       3.2       2.9
## 2 Female       3.7         4
## 3   Male       3.4       3.1
## 4 Female       3.6       3.9
```

## Adding Columns
What if we come across more data and we want to add it to our data frame? We can also do that with the `$` operator.

```r
hbirds$neighborhood <- c("Lakewood", "Brentwood", "Lakewood", "Scenic Heights")
hbirds
```

```
##      sex length_in weight_oz   neighborhood
## 1   Male       3.2       2.9       Lakewood
## 2 Female       3.7         4      Brentwood
## 3   Male       3.4       3.1       Lakewood
## 4 Female       3.6       3.9 Scenic Heights
```


```r
dim(hbirds)
```

```
## [1] 4 4
```

## Writing Data to File
We should save our hbirds data frame so we can use it again later! There are many ways to save data in R, here we write our data frame to a csv file. We use  `row.names = FALSE` to avoid row numbers from printing out. 

```r
write.csv(hbirds, "hbirds_data.csv", row.names = FALSE)
```


```r
getwd()
```

```
## [1] "/Users/alvarezlean/Desktop/BIS15W2021_lalvarez/lab3"
```

to put in data folder

```r
write.csv(hbirds, "data/hbirds_data.csv", row.names = FALSE)
```


 
## Practice
Below are data collected by three scientists (Jill, Steve, Susan in order) measuring temperatures of three hot springs near Mono Lake.

```r
temp <- c(36.25, 35.40, 35.30, 35.15, 35.35, 33.35, 30.70, 29.65, 29.20)
name <- c("Jill", "Susan", "Steve", "Jill", "Susan", "Steve", "Jill", "Susan", "Steve")
spring <- c("Buckeye", "Buckeye", "Buckeye", "Benton", "Benton", "Benton", "Travertine", "Travertine", "Travertine")
```

1. Build a data frame called `hsprings` with the above data. Name the temperature column `temp_C`. Print out the data frame.  

```r
hsprings <- data.frame(temp_C = temp, name, spring)
hsprings
```

```
##   temp_C  name     spring
## 1  36.25  Jill    Buckeye
## 2  35.40 Susan    Buckeye
## 3  35.30 Steve    Buckeye
## 4  35.15  Jill     Benton
## 5  35.35 Susan     Benton
## 6  33.35 Steve     Benton
## 7  30.70  Jill Travertine
## 8  29.65 Susan Travertine
## 9  29.20 Steve Travertine
```

to reorder columns, just change order of vector


2. Change the column titled `name` to `scientist`, leave the other column names the same. Print out the data frame names.  

```r
hsprings <- data.frame(temp_C = temp, scientist = name, spring )
hsprings
```

```
##   temp_C scientist     spring
## 1  36.25      Jill    Buckeye
## 2  35.40     Susan    Buckeye
## 3  35.30     Steve    Buckeye
## 4  35.15      Jill     Benton
## 5  35.35     Susan     Benton
## 6  33.35     Steve     Benton
## 7  30.70      Jill Travertine
## 8  29.65     Susan Travertine
## 9  29.20     Steve Travertine
```

3. Our scientists forgot to record the depth data for each spring. Here it is as a vector, add it as a new column called depth_ft: `c(4.15, 4.13, 4.12, 3.21, 3.23, 3.20, 5.67, 5.65, 5.66)`. Print out the data frame.

```r
depth_ft <-c(4.15, 4.13, 4.12, 3.21, 3.23, 3.20, 5.67, 5.65, 5.66)
hsprings <- cbind(temp_C = temp, scientist = name, spring, depth_ft )
hsprings
```

```
##       temp_C  scientist spring       depth_ft
##  [1,] "36.25" "Jill"    "Buckeye"    "4.15"  
##  [2,] "35.4"  "Susan"   "Buckeye"    "4.13"  
##  [3,] "35.3"  "Steve"   "Buckeye"    "4.12"  
##  [4,] "35.15" "Jill"    "Benton"     "3.21"  
##  [5,] "35.35" "Susan"   "Benton"     "3.23"  
##  [6,] "33.35" "Steve"   "Benton"     "3.2"   
##  [7,] "30.7"  "Jill"    "Travertine" "5.67"  
##  [8,] "29.65" "Susan"   "Travertine" "5.65"  
##  [9,] "29.2"  "Steve"   "Travertine" "5.66"
```
 OR
 

```r
hsprings <- cbind(hsprings, depth_ft)
hsprings
```

```
##       temp_C  scientist spring       depth_ft depth_ft
##  [1,] "36.25" "Jill"    "Buckeye"    "4.15"   "4.15"  
##  [2,] "35.4"  "Susan"   "Buckeye"    "4.13"   "4.13"  
##  [3,] "35.3"  "Steve"   "Buckeye"    "4.12"   "4.12"  
##  [4,] "35.15" "Jill"    "Benton"     "3.21"   "3.21"  
##  [5,] "35.35" "Susan"   "Benton"     "3.23"   "3.23"  
##  [6,] "33.35" "Steve"   "Benton"     "3.2"    "3.2"   
##  [7,] "30.7"  "Jill"    "Travertine" "5.67"   "5.67"  
##  [8,] "29.65" "Susan"   "Travertine" "5.65"   "5.65"  
##  [9,] "29.2"  "Steve"   "Travertine" "5.66"   "5.66"
```
 
4. Calculate the mean temperature of all of the temperature measurements.



5. Save your hot springs data as a `.csv` file! Do not allow row names. 

```r
write.csv(hsprings, "data/hsprings_data.csv", row.names = FALSE)
```

## That's it! Take a break and I will see you on Zoom!  

-->[Home](https://jmledford3115.github.io/datascibiol/)  

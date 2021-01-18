---
title: "Lab 4 Homework"
author: "Lean Alvarez"
date: "2021-01-18"
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

## Data
For the homework, we will use data about vertebrate home range sizes. The data are in the class folder, but the reference is below.  

**Database of vertebrate home range sizes.**  
Reference: Tamburello N, Cote IM, Dulvy NK (2015) Energy and the scaling of animal space use. The American Naturalist 186(2):196-211. http://dx.doi.org/10.1086/682070.  
Data: http://datadryad.org/resource/doi:10.5061/dryad.q5j65/1  


**1. Load the data into a new object called `homerange`.**

```r
homerange <- readr::read_csv("data/Tamburelloetal_HomeRangeDatabase.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   .default = col_character(),
##   mean.mass.g = col_double(),
##   log10.mass = col_double(),
##   mean.hra.m2 = col_double(),
##   log10.hra = col_double(),
##   preymass = col_double(),
##   log10.preymass = col_double(),
##   PPMR = col_double()
## )
## ℹ Use `spec()` for the full column specifications.
```


**2. Explore the data. Show the dimensions, column names, classes for each variable, and a statistical summary. Keep these as separate code chunks.**  

```r
dim(homerange)
```

```
## [1] 569  24
```

```r
names(homerange)
```

```
##  [1] "taxon"                      "common.name"               
##  [3] "class"                      "order"                     
##  [5] "family"                     "genus"                     
##  [7] "species"                    "primarymethod"             
##  [9] "N"                          "mean.mass.g"               
## [11] "log10.mass"                 "alternative.mass.reference"
## [13] "mean.hra.m2"                "log10.hra"                 
## [15] "hra.reference"              "realm"                     
## [17] "thermoregulation"           "locomotion"                
## [19] "trophic.guild"              "dimension"                 
## [21] "preymass"                   "log10.preymass"            
## [23] "PPMR"                       "prey.size.reference"
```

```r
summary(homerange)
```

```
##     taxon           common.name           class              order          
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##     family             genus             species          primarymethod     
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##       N              mean.mass.g        log10.mass     
##  Length:569         Min.   :      0   Min.   :-0.6576  
##  Class :character   1st Qu.:     50   1st Qu.: 1.6990  
##  Mode  :character   Median :    330   Median : 2.5185  
##                     Mean   :  34602   Mean   : 2.5947  
##                     3rd Qu.:   2150   3rd Qu.: 3.3324  
##                     Max.   :4000000   Max.   : 6.6021  
##                                                        
##  alternative.mass.reference  mean.hra.m2          log10.hra     
##  Length:569                 Min.   :0.000e+00   Min.   :-1.523  
##  Class :character           1st Qu.:4.500e+03   1st Qu.: 3.653  
##  Mode  :character           Median :3.934e+04   Median : 4.595  
##                             Mean   :2.146e+07   Mean   : 4.709  
##                             3rd Qu.:1.038e+06   3rd Qu.: 6.016  
##                             Max.   :3.551e+09   Max.   : 9.550  
##                                                                 
##  hra.reference         realm           thermoregulation    locomotion       
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##  trophic.guild       dimension            preymass         log10.preymass   
##  Length:569         Length:569         Min.   :     0.67   Min.   :-0.1739  
##  Class :character   Class :character   1st Qu.:    20.02   1st Qu.: 1.3014  
##  Mode  :character   Mode  :character   Median :    53.75   Median : 1.7304  
##                                        Mean   :  3989.88   Mean   : 2.0188  
##                                        3rd Qu.:   363.35   3rd Qu.: 2.5603  
##                                        Max.   :130233.20   Max.   : 5.1147  
##                                        NA's   :502         NA's   :502      
##       PPMR         prey.size.reference
##  Min.   :  0.380   Length:569         
##  1st Qu.:  3.315   Class :character   
##  Median :  7.190   Mode  :character   
##  Mean   : 31.752                      
##  3rd Qu.: 15.966                      
##  Max.   :530.000                      
##  NA's   :502
```


**3. Change the class of the variables `taxon` and `order` to factors and display their levels.**  

```r
homerange$taxon <- as.factor(homerange$taxon)
class(homerange$taxon)
```

```
## [1] "factor"
```


```r
homerange$order <- as.factor(homerange$order)
class(homerange$order)
```

```
## [1] "factor"
```


```r
levels(homerange$taxon)
```

```
## [1] "birds"         "lake fishes"   "lizards"       "mammals"      
## [5] "marine fishes" "river fishes"  "snakes"        "tortoises"    
## [9] "turtles"
```


```r
levels(homerange$order)
```

```
##  [1] "accipitriformes"    "afrosoricida"       "anguilliformes"    
##  [4] "anseriformes"       "apterygiformes"     "artiodactyla"      
##  [7] "caprimulgiformes"   "carnivora"          "charadriiformes"   
## [10] "columbidormes"      "columbiformes"      "coraciiformes"     
## [13] "cuculiformes"       "cypriniformes"      "dasyuromorpha"     
## [16] "dasyuromorpia"      "didelphimorphia"    "diprodontia"       
## [19] "diprotodontia"      "erinaceomorpha"     "esociformes"       
## [22] "falconiformes"      "gadiformes"         "galliformes"       
## [25] "gruiformes"         "lagomorpha"         "macroscelidea"     
## [28] "monotrematae"       "passeriformes"      "pelecaniformes"    
## [31] "peramelemorphia"    "perciformes"        "perissodactyla"    
## [34] "piciformes"         "pilosa"             "proboscidea"       
## [37] "psittaciformes"     "rheiformes"         "roden"             
## [40] "rodentia"           "salmoniformes"      "scorpaeniformes"   
## [43] "siluriformes"       "soricomorpha"       "squamata"          
## [46] "strigiformes"       "struthioniformes"   "syngnathiformes"   
## [49] "testudines"         "tetraodontiformes\xa0" "tinamiformes"
```


**4. What taxa are represented in the `homerange` data frame? Make a new data frame `taxa` that is restricted to taxon, common name, class, order, family, genus, species.**  

```r
homerange_restricted <- select(homerange, "taxon", common_name = "common.name", "class", "order", "family", "genus", "species")
homerange_restricted
```

```
## # A tibble: 569 x 7
##    taxon     common_name       class      order     family    genus    species  
##    <fct>     <chr>             <chr>      <fct>     <chr>     <chr>    <chr>    
##  1 lake fis… american eel      actinopte… anguilli… anguilli… anguilla rostrata 
##  2 river fi… blacktail redhor… actinopte… cyprinif… catostom… moxosto… poecilura
##  3 river fi… central stonerol… actinopte… cyprinif… cyprinid… campost… anomalum 
##  4 river fi… rosyside dace     actinopte… cyprinif… cyprinid… clinost… funduloi…
##  5 river fi… longnose dace     actinopte… cyprinif… cyprinid… rhinich… cataract…
##  6 river fi… muskellunge       actinopte… esocifor… esocidae  esox     masquino…
##  7 marine f… pollack           actinopte… gadiform… gadidae   pollach… pollachi…
##  8 marine f… saithe            actinopte… gadiform… gadidae   pollach… virens   
##  9 marine f… lined surgeonfish actinopte… percifor… acanthur… acanthu… lineatus 
## 10 marine f… orangespine unic… actinopte… percifor… acanthur… naso     lituratus
## # … with 559 more rows
```
Lake fishes, river fishes, marine fishes, birds, mammals, snakes, lizards, turtles, and tortoises are the taxa represented in the 'homerange' data.


**5. The variable `taxon` identifies the large, common name groups of the species represented in `homerange`. Make a table that shows the counts for each of these `taxon`.**  

```r
table(homerange$taxon)
```

```
## 
##         birds   lake fishes       lizards       mammals marine fishes 
##           140             9            11           238            90 
##  river fishes        snakes     tortoises       turtles 
##            14            41            12            14
```


**6. The species in `homerange` are also classified into trophic guilds. How many species are represented in each trophic guild.**  

```r
trophic_guilds <- select(homerange, "species", trophic_guild = "trophic.guild")
trophic_guilds
```

```
## # A tibble: 569 x 2
##    species     trophic_guild
##    <chr>       <chr>        
##  1 rostrata    carnivore    
##  2 poecilura   carnivore    
##  3 anomalum    carnivore    
##  4 funduloides carnivore    
##  5 cataractae  carnivore    
##  6 masquinongy carnivore    
##  7 pollachius  carnivore    
##  8 virens      carnivore    
##  9 lineatus    herbivore    
## 10 lituratus   herbivore    
## # … with 559 more rows
```


```r
carnivore_species <- filter(trophic_guilds, trophic_guild == "carnivore")
carnivore_species
```

```
## # A tibble: 342 x 2
##    species     trophic_guild
##    <chr>       <chr>        
##  1 rostrata    carnivore    
##  2 poecilura   carnivore    
##  3 anomalum    carnivore    
##  4 funduloides carnivore    
##  5 cataractae  carnivore    
##  6 masquinongy carnivore    
##  7 pollachius  carnivore    
##  8 virens      carnivore    
##  9 ignobilis   carnivore    
## 10 rupestris   carnivore    
## # … with 332 more rows
```

```r
nrow(carnivore_species)
```

```
## [1] 342
```
There are 342 carnivores.


```r
herbivore_species <- filter(trophic_guilds, trophic_guild == "herbivore")
herbivore_species
```

```
## # A tibble: 227 x 2
##    species    trophic_guild
##    <chr>      <chr>        
##  1 lineatus   herbivore    
##  2 lituratus  herbivore    
##  3 unicornis  herbivore    
##  4 atlanticus herbivore    
##  5 sectatrix  herbivore    
##  6 argi       herbivore    
##  7 chromis    herbivore    
##  8 biocellata herbivore    
##  9 wardi      herbivore    
## 10 apicalis   herbivore    
## # … with 217 more rows
```

```r
nrow(herbivore_species)
```

```
## [1] 227
```
There are 227 herbivores.




**7. Make two new data frames, one which is restricted to carnivores and another that is restricted to herbivores.**  

```r
carnivores <- filter(homerange, trophic.guild == "carnivore")
carnivores
```

```
## # A tibble: 342 x 24
##    taxon common.name class order family genus species primarymethod N    
##    <fct> <chr>       <chr> <fct> <chr>  <chr> <chr>   <chr>         <chr>
##  1 lake… american e… acti… angu… angui… angu… rostra… telemetry     16   
##  2 rive… blacktail … acti… cypr… catos… moxo… poecil… mark-recaptu… <NA> 
##  3 rive… central st… acti… cypr… cypri… camp… anomal… mark-recaptu… 20   
##  4 rive… rosyside d… acti… cypr… cypri… clin… fundul… mark-recaptu… 26   
##  5 rive… longnose d… acti… cypr… cypri… rhin… catara… mark-recaptu… 17   
##  6 rive… muskellunge acti… esoc… esoci… esox  masqui… telemetry     5    
##  7 mari… pollack     acti… gadi… gadid… poll… pollac… telemetry     2    
##  8 mari… saithe      acti… gadi… gadid… poll… virens  telemetry     2    
##  9 mari… giant trev… acti… perc… caran… cara… ignobi… telemetry     4    
## 10 lake… rock bass   acti… perc… centr… ambl… rupest… mark-recaptu… 16   
## # … with 332 more rows, and 15 more variables: mean.mass.g <dbl>,
## #   log10.mass <dbl>, alternative.mass.reference <chr>, mean.hra.m2 <dbl>,
## #   log10.hra <dbl>, hra.reference <chr>, realm <chr>, thermoregulation <chr>,
## #   locomotion <chr>, trophic.guild <chr>, dimension <chr>, preymass <dbl>,
## #   log10.preymass <dbl>, PPMR <dbl>, prey.size.reference <chr>
```


```r
herbivores <- filter(homerange, trophic.guild == "herbivore")
herbivores
```

```
## # A tibble: 227 x 24
##    taxon common.name class order family genus species primarymethod N    
##    <fct> <chr>       <chr> <fct> <chr>  <chr> <chr>   <chr>         <chr>
##  1 mari… lined surg… acti… perc… acant… acan… lineat… direct obser… <NA> 
##  2 mari… orangespin… acti… perc… acant… naso  litura… telemetry     8    
##  3 mari… bluespine … acti… perc… acant… naso  unicor… telemetry     7    
##  4 mari… redlip ble… acti… perc… blenn… ophi… atlant… direct obser… 20   
##  5 mari… bermuda ch… acti… perc… kypho… kyph… sectat… telemetry     11   
##  6 mari… cherubfish  acti… perc… pomac… cent… argi    direct obser… <NA> 
##  7 mari… damselfish  acti… perc… pomac… chro… chromis direct obser… <NA> 
##  8 mari… twinspot d… acti… perc… pomac… chry… biocel… direct obser… 18   
##  9 mari… wards dams… acti… perc… pomac… poma… wardi   direct obser… <NA> 
## 10 mari… australian… acti… perc… pomac… steg… apical… direct obser… <NA> 
## # … with 217 more rows, and 15 more variables: mean.mass.g <dbl>,
## #   log10.mass <dbl>, alternative.mass.reference <chr>, mean.hra.m2 <dbl>,
## #   log10.hra <dbl>, hra.reference <chr>, realm <chr>, thermoregulation <chr>,
## #   locomotion <chr>, trophic.guild <chr>, dimension <chr>, preymass <dbl>,
## #   log10.preymass <dbl>, PPMR <dbl>, prey.size.reference <chr>
```



**8. Do herbivores or carnivores have, on average, a larger `mean.hra.m2`? Remove any NAs from the data.**  


```r
avg_herbivore <- herbivores$mean.hra.m2
mean(avg_herbivore, na.rm=T)
```

```
## [1] 34137012
```


```r
avg_carnivore <- carnivores$mean.hra.m2
mean(avg_carnivore, na.rm=T)
```

```
## [1] 13039918
```
On average, herbivores have a larger mean.hra.m2.




**9. Make a new dataframe `deer` that is limited to the mean mass, log10 mass, family, genus, and species of deer in the database. The family for deer is cervidae. Arrange the data in descending order by log10 mass. Which is the largest deer? What is its common name?** 

```r
not_just_deer <- select(homerange, "mean.mass.g", "log10.mass", "family", "genus", "species")
not_just_deer
```

```
## # A tibble: 569 x 5
##    mean.mass.g log10.mass family       genus       species    
##          <dbl>      <dbl> <chr>        <chr>       <chr>      
##  1        887       2.95  anguillidae  anguilla    rostrata   
##  2        562       2.75  catostomidae moxostoma   poecilura  
##  3         34       1.53  cyprinidae   campostoma  anomalum   
##  4          4       0.602 cyprinidae   clinostomus funduloides
##  5          4       0.602 cyprinidae   rhinichthys cataractae 
##  6       3525       3.55  esocidae     esox        masquinongy
##  7        737.      2.87  gadidae      pollachius  pollachius 
##  8        449.      2.65  gadidae      pollachius  virens     
##  9        109.      2.04  acanthuridae acanthurus  lineatus   
## 10        772.      2.89  acanthuridae naso        lituratus  
## # … with 559 more rows
```


```r
deer_wrong_names <- filter(not_just_deer, family == "cervidae")
deer <- rename(deer_wrong_names, mean_mass_g = "mean.mass.g", log10_mass = "log10.mass")
view(deer)
```


```r
filter(homerange, family == "cervidae", genus == "alces")
```

```
## # A tibble: 1 x 24
##   taxon common.name class order family genus species primarymethod N    
##   <fct> <chr>       <chr> <fct> <chr>  <chr> <chr>   <chr>         <chr>
## 1 mamm… moose       mamm… arti… cervi… alces alces   telemetry*    <NA> 
## # … with 15 more variables: mean.mass.g <dbl>, log10.mass <dbl>,
## #   alternative.mass.reference <chr>, mean.hra.m2 <dbl>, log10.hra <dbl>,
## #   hra.reference <chr>, realm <chr>, thermoregulation <chr>, locomotion <chr>,
## #   trophic.guild <chr>, dimension <chr>, preymass <dbl>, log10.preymass <dbl>,
## #   PPMR <dbl>, prey.size.reference <chr>
```
The largest deer is "alces," and its common name is "moose."




**10. As measured by the data, which snake species has the smallest homerange? Show all of your work, please. Look this species up online and tell me about it!** **Snake is found in taxon column**    

```r
smallest_snake <- filter(homerange, taxon == "snakes")
view(smallest_snake)
```
The snake species "schneideri" has the smallest homerange. According to (https://www.africansnakebiteinstitute.com/snake/namaqua-dwarf-adder/), "scheideri", also known as the "namaqua dwarf adder," is mostly out during the day, it is located in South Africa, it eats lizards and Rain frogs, and it is "the smallest adder in the world."


## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   

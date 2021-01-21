---
title: "dplyr Superhero"
author: "Lean Alvarez"
date: "2021-01-20"
output:
  html_document: 
    theme: spacelab
    toc: yes
    toc_float: yes
    keep_md: yes
---

## Breakout Rooms  
Please take 5-8 minutes to check over your answers to the HW in your group. If you are stuck, please remember that you can check the key in [Joel's repository](https://github.com/jmledford3115/BIS15LW2021_jledford).  

## Learning Goals  
*At the end of this exercise, you will be able to:*    
1. Develop your dplyr superpowers so you can easily and confidently manipulate dataframes.  
2. Learn helpful new functions that are part of the `janitor` package.  

## Instructions
For the second part of lab 5 today, we are going to spend time practicing the dplyr functions we have learned and add a few new ones. We will spend most of the time in our breakout rooms. Your lab 5 homework will be to knit and push this file to your repository.  

## Load the tidyverse

```r
library("tidyverse")
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
```

```
## ✓ ggplot2 3.3.3     ✓ purrr   0.3.4
## ✓ tibble  3.0.4     ✓ dplyr   1.0.2
## ✓ tidyr   1.1.2     ✓ stringr 1.4.0
## ✓ readr   1.4.0     ✓ forcats 0.5.0
```

```
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

## Load the superhero data
These are data taken from comic books and assembled by fans. The include a good mix of categorical and continuous data.  Data taken from: https://www.kaggle.com/claudiodavi/superhero-set  

Check out the way I am loading these data. If I know there are NAs, I can take care of them at the beginning. But, we should do this very cautiously. At times it is better to keep the original columns and data intact.  

```r
superhero_info <- readr::read_csv("data/heroes_information.csv", na = c("", "-99", "-"))
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   name = col_character(),
##   Gender = col_character(),
##   `Eye color` = col_character(),
##   Race = col_character(),
##   `Hair color` = col_character(),
##   Height = col_double(),
##   Publisher = col_character(),
##   `Skin color` = col_character(),
##   Alignment = col_character(),
##   Weight = col_double()
## )
```

```r
superhero_powers <- readr::read_csv("data/super_hero_powers.csv", na = c("", "-99", "-"))
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   .default = col_logical(),
##   hero_names = col_character()
## )
## ℹ Use `spec()` for the full column specifications.
```

## Data tidy
1. Some of the names used in the `superhero_info` data are problematic so you should rename them here.  

```r
superhero_info %>% 
  rename(eye_color = "Eye color", hair_color = "Hair color", skin_color = "Skin color") %>% 
  select_all(tolower) %>% 
  mutate_all(tolower)
```

```
## # A tibble: 734 x 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>      <chr>  <chr>     <chr>      <chr>    
##  1 a-bo… male   yellow    human no hair    203    marvel c… <NA>       good     
##  2 abe … male   blue      icth… no hair    191    dark hor… blue       good     
##  3 abin… male   blue      unga… no hair    185    dc comics red        good     
##  4 abom… male   green     huma… no hair    203    marvel c… <NA>       bad      
##  5 abra… male   blue      cosm… black      <NA>   marvel c… <NA>       bad      
##  6 abso… male   blue      human no hair    193    marvel c… <NA>       bad      
##  7 adam… male   blue      <NA>  blond      <NA>   nbc - he… <NA>       good     
##  8 adam… male   blue      human blond      185    dc comics <NA>       good     
##  9 agen… female blue      <NA>  blond      173    marvel c… <NA>       good     
## 10 agen… male   brown     human brown      178    marvel c… <NA>       good     
## # … with 724 more rows, and 1 more variable: weight <chr>
```

Yikes! `superhero_powers` has a lot of variables that are poorly named. We need some R superpowers...

```r
superhero_powers %>% 
  select_all(tolower) %>% 
  mutate_all(tolower) %>% 
  select_all(~str_replace(., " ", "_"))
```

```
## # A tibble: 667 x 168
##    hero_names agility accelerated_hea… `lantern_power … dimensional_awa…
##    <chr>      <chr>   <chr>            <chr>            <chr>           
##  1 3-d man    true    false            false            false           
##  2 a-bomb     false   true             false            false           
##  3 abe sapien true    true             false            false           
##  4 abin sur   false   false            true             false           
##  5 abominati… false   true             false            false           
##  6 abraxas    false   false            false            true            
##  7 absorbing… false   false            false            false           
##  8 adam monr… false   true             false            false           
##  9 adam stra… false   false            false            false           
## 10 agent bob  false   false            false            false           
## # … with 657 more rows, and 163 more variables: cold_resistance <chr>,
## #   durability <chr>, stealth <chr>, energy_absorption <chr>, flight <chr>,
## #   danger_sense <chr>, underwater_breathing <chr>, marksmanship <chr>,
## #   weapons_master <chr>, power_augmentation <chr>, animal_attributes <chr>,
## #   longevity <chr>, intelligence <chr>, super_strength <chr>,
## #   cryokinesis <chr>, telepathy <chr>, energy_armor <chr>,
## #   energy_blasts <chr>, duplication <chr>, size_changing <chr>,
## #   density_control <chr>, stamina <chr>, astral_travel <chr>,
## #   audio_control <chr>, dexterity <chr>, omnitrix <chr>, super_speed <chr>,
## #   possession <chr>, `animal_oriented powers` <chr>,
## #   `weapon-based_powers` <chr>, electrokinesis <chr>,
## #   darkforce_manipulation <chr>, death_touch <chr>, teleportation <chr>,
## #   enhanced_senses <chr>, telekinesis <chr>, energy_beams <chr>, magic <chr>,
## #   hyperkinesis <chr>, jump <chr>, clairvoyance <chr>,
## #   dimensional_travel <chr>, power_sense <chr>, shapeshifting <chr>,
## #   `peak_human condition` <chr>, immortality <chr>, camouflage <chr>,
## #   element_control <chr>, phasing <chr>, astral_projection <chr>,
## #   electrical_transport <chr>, fire_control <chr>, projection <chr>,
## #   summoning <chr>, enhanced_memory <chr>, reflexes <chr>,
## #   invulnerability <chr>, energy_constructs <chr>, force_fields <chr>,
## #   `self-sustenance` <chr>, `anti-gravity` <chr>, empathy <chr>,
## #   power_nullifier <chr>, radiation_control <chr>, psionic_powers <chr>,
## #   elasticity <chr>, substance_secretion <chr>,
## #   elemental_transmogrification <chr>, `technopath/cyberpath` <chr>,
## #   photographic_reflexes <chr>, seismic_power <chr>, animation <chr>,
## #   precognition <chr>, mind_control <chr>, fire_resistance <chr>,
## #   power_absorption <chr>, enhanced_hearing <chr>, nova_force <chr>,
## #   insanity <chr>, hypnokinesis <chr>, animal_control <chr>,
## #   natural_armor <chr>, intangibility <chr>, enhanced_sight <chr>,
## #   molecular_manipulation <chr>, heat_generation <chr>, adaptation <chr>,
## #   gliding <chr>, power_suit <chr>, mind_blast <chr>,
## #   probability_manipulation <chr>, gravity_control <chr>, regeneration <chr>,
## #   light_control <chr>, echolocation <chr>, levitation <chr>, `toxin_and
## #   disease control` <chr>, banish <chr>, energy_manipulation <chr>,
## #   heat_resistance <chr>, …
```


## `janitor`
The [janitor](https://garthtarr.github.io/meatR/janitor.html) package is your friend. Make sure to install it and then load the library.


```r
library("janitor")
```

```
## 
## Attaching package: 'janitor'
```

```
## The following objects are masked from 'package:stats':
## 
##     chisq.test, fisher.test
```

The `clean_names` function takes care of everything in one line! Now that's a superpower!

```r
superhero_powers <- janitor::clean_names(superhero_powers)
superhero_info <- janitor::clean_names(superhero_info)
```

## `tabyl`
The `janitor` package has many awesome functions that we will explore. Here is its version of `table` which not only produces counts but also percentages. Very handy! Let's use it to explore the proportion of good guys and bad guys in the `superhero_info` data.  

```r
tabyl(superhero_info, alignment)
```

```
##  alignment   n     percent valid_percent
##        bad 207 0.282016349    0.28473177
##       good 496 0.675749319    0.68225585
##    neutral  24 0.032697548    0.03301238
##       <NA>   7 0.009536785            NA
```

2. Notice that we have some neutral superheros! Who are they?

```r
superhero_info %>% 
  select(name, alignment) %>% 
  filter(alignment=="neutral")
```

```
## # A tibble: 24 x 2
##    name         alignment
##    <chr>        <chr>    
##  1 Bizarro      neutral  
##  2 Black Flash  neutral  
##  3 Captain Cold neutral  
##  4 Copycat      neutral  
##  5 Deadpool     neutral  
##  6 Deathstroke  neutral  
##  7 Etrigan      neutral  
##  8 Galactus     neutral  
##  9 Gladiator    neutral  
## 10 Indigo       neutral  
## # … with 14 more rows
```



## `superhero_info`
3. Let's say we are only interested in the variables name, alignment, and "race". How would you isolate these variables from `superhero_info`?

```r
superhero_info %>% 
  select(name, alignment, race)
```

```
## # A tibble: 734 x 3
##    name          alignment race             
##    <chr>         <chr>     <chr>            
##  1 A-Bomb        good      Human            
##  2 Abe Sapien    good      Icthyo Sapien    
##  3 Abin Sur      good      Ungaran          
##  4 Abomination   bad       Human / Radiation
##  5 Abraxas       bad       Cosmic Entity    
##  6 Absorbing Man bad       Human            
##  7 Adam Monroe   good      <NA>             
##  8 Adam Strange  good      Human            
##  9 Agent 13      good      <NA>             
## 10 Agent Bob     good      Human            
## # … with 724 more rows
```


## Not Human
4. List all of the superheros that are not human.

```r
superhero_info %>% 
  select(name, race) %>% 
  filter(race !="Human")
```

```
## # A tibble: 222 x 2
##    name         race             
##    <chr>        <chr>            
##  1 Abe Sapien   Icthyo Sapien    
##  2 Abin Sur     Ungaran          
##  3 Abomination  Human / Radiation
##  4 Abraxas      Cosmic Entity    
##  5 Ajax         Cyborg           
##  6 Alien        Xenomorph XX121  
##  7 Amazo        Android          
##  8 Angel        Vampire          
##  9 Angel Dust   Mutant           
## 10 Anti-Monitor God / Eternal    
## # … with 212 more rows
```


## Good and Evil
5. Let's make two different data frames, one focused on the "good guys" and another focused on the "bad guys".

```r
good_guys <- superhero_info %>% 
  filter(alignment=="good")
good_guys
```

```
## # A tibble: 496 x 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 A-Bo… Male   yellow    Human No Hair       203 Marvel C… <NA>       good     
##  2 Abe … Male   blue      Icth… No Hair       191 Dark Hor… blue       good     
##  3 Abin… Male   blue      Unga… No Hair       185 DC Comics red        good     
##  4 Adam… Male   blue      <NA>  Blond          NA NBC - He… <NA>       good     
##  5 Adam… Male   blue      Human Blond         185 DC Comics <NA>       good     
##  6 Agen… Female blue      <NA>  Blond         173 Marvel C… <NA>       good     
##  7 Agen… Male   brown     Human Brown         178 Marvel C… <NA>       good     
##  8 Agen… Male   <NA>      <NA>  <NA>          191 Marvel C… <NA>       good     
##  9 Alan… Male   blue      <NA>  Blond         180 DC Comics <NA>       good     
## 10 Alex… Male   <NA>      <NA>  <NA>           NA NBC - He… <NA>       good     
## # … with 486 more rows, and 1 more variable: weight <dbl>
```


```r
bad_guys <- superhero_info %>% 
  filter(alignment=="bad")
bad_guys
```

```
## # A tibble: 207 x 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Abom… Male   green     Huma… No Hair       203 Marvel C… <NA>       bad      
##  2 Abra… Male   blue      Cosm… Black          NA Marvel C… <NA>       bad      
##  3 Abso… Male   blue      Human No Hair       193 Marvel C… <NA>       bad      
##  4 Air-… Male   blue      <NA>  White         188 Marvel C… <NA>       bad      
##  5 Ajax  Male   brown     Cybo… Black         193 Marvel C… <NA>       bad      
##  6 Alex… Male   <NA>      Human <NA>           NA Wildstorm <NA>       bad      
##  7 Alien Male   <NA>      Xeno… No Hair       244 Dark Hor… black      bad      
##  8 Amazo Male   red       Andr… <NA>          257 DC Comics <NA>       bad      
##  9 Ammo  Male   brown     Human Black         188 Marvel C… <NA>       bad      
## 10 Ange… Female <NA>      <NA>  <NA>           NA Image Co… <NA>       bad      
## # … with 197 more rows, and 1 more variable: weight <dbl>
```

6. For the good guys, use the `tabyl` function to summarize their "race".

```r
good_guys %>% 
  tabyl(race)
```

```
##               race   n     percent valid_percent
##              Alien   3 0.006048387   0.010752688
##              Alpha   5 0.010080645   0.017921147
##             Amazon   2 0.004032258   0.007168459
##            Android   4 0.008064516   0.014336918
##             Animal   2 0.004032258   0.007168459
##          Asgardian   3 0.006048387   0.010752688
##          Atlantean   4 0.008064516   0.014336918
##         Bolovaxian   1 0.002016129   0.003584229
##              Clone   1 0.002016129   0.003584229
##             Cyborg   3 0.006048387   0.010752688
##           Demi-God   2 0.004032258   0.007168459
##              Demon   3 0.006048387   0.010752688
##            Eternal   1 0.002016129   0.003584229
##     Flora Colossus   1 0.002016129   0.003584229
##        Frost Giant   1 0.002016129   0.003584229
##      God / Eternal   6 0.012096774   0.021505376
##             Gungan   1 0.002016129   0.003584229
##              Human 148 0.298387097   0.530465950
##    Human / Altered   2 0.004032258   0.007168459
##     Human / Cosmic   2 0.004032258   0.007168459
##  Human / Radiation   8 0.016129032   0.028673835
##         Human-Kree   2 0.004032258   0.007168459
##      Human-Spartoi   1 0.002016129   0.003584229
##       Human-Vulcan   1 0.002016129   0.003584229
##    Human-Vuldarian   1 0.002016129   0.003584229
##      Icthyo Sapien   1 0.002016129   0.003584229
##            Inhuman   4 0.008064516   0.014336918
##    Kakarantharaian   1 0.002016129   0.003584229
##         Kryptonian   4 0.008064516   0.014336918
##            Martian   1 0.002016129   0.003584229
##          Metahuman   1 0.002016129   0.003584229
##             Mutant  46 0.092741935   0.164874552
##     Mutant / Clone   1 0.002016129   0.003584229
##             Planet   1 0.002016129   0.003584229
##             Saiyan   1 0.002016129   0.003584229
##           Symbiote   3 0.006048387   0.010752688
##           Talokite   1 0.002016129   0.003584229
##         Tamaranean   1 0.002016129   0.003584229
##            Ungaran   1 0.002016129   0.003584229
##            Vampire   2 0.004032258   0.007168459
##     Yoda's species   1 0.002016129   0.003584229
##      Zen-Whoberian   1 0.002016129   0.003584229
##               <NA> 217 0.437500000            NA
```

7. Among the good guys, Who are the Asgardians?

```r
good_guys %>% 
  filter(race=="Asgardian")
```

```
## # A tibble: 3 x 10
##   name  gender eye_color race  hair_color height publisher skin_color alignment
##   <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
## 1 Sif   Female blue      Asga… Black         188 Marvel C… <NA>       good     
## 2 Thor  Male   blue      Asga… Blond         198 Marvel C… <NA>       good     
## 3 Thor… Female blue      Asga… Blond         175 Marvel C… <NA>       good     
## # … with 1 more variable: weight <dbl>
```

8. Among the bad guys, who are the male humans over 200 inches in height?

```r
bad_guys %>% 
  filter(gender=="Male", race=="Human", height>200)
```

```
## # A tibble: 5 x 10
##   name  gender eye_color race  hair_color height publisher skin_color alignment
##   <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
## 1 Bane  Male   <NA>      Human <NA>          203 DC Comics <NA>       bad      
## 2 Doct… Male   brown     Human Brown         201 Marvel C… <NA>       bad      
## 3 King… Male   blue      Human No Hair       201 Marvel C… <NA>       bad      
## 4 Liza… Male   red       Human No Hair       203 Marvel C… <NA>       bad      
## 5 Scor… Male   brown     Human Brown         211 Marvel C… <NA>       bad      
## # … with 1 more variable: weight <dbl>
```


9. OK, so are there more good guys or bad guys that are bald (personal interest)?

```r
good_guys_bald <- good_guys%>% 
  filter(hair_color=="No Hair")
good_guys_bald
```

```
## # A tibble: 37 x 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 A-Bo… Male   yellow    Human No Hair       203 Marvel C… <NA>       good     
##  2 Abe … Male   blue      Icth… No Hair       191 Dark Hor… blue       good     
##  3 Abin… Male   blue      Unga… No Hair       185 DC Comics red        good     
##  4 Beta… Male   <NA>      <NA>  No Hair       201 Marvel C… <NA>       good     
##  5 Bish… Male   brown     Muta… No Hair       198 Marvel C… <NA>       good     
##  6 Blac… Male   brown     <NA>  No Hair       185 DC Comics <NA>       good     
##  7 Blaq… <NA>   black     <NA>  No Hair        NA Marvel C… <NA>       good     
##  8 Bloo… Male   black     Muta… No Hair        NA Marvel C… <NA>       good     
##  9 Crim… Male   brown     <NA>  No Hair       180 Marvel C… <NA>       good     
## 10 Dona… Male   green     Muta… No Hair        NA IDW Publ… green      good     
## # … with 27 more rows, and 1 more variable: weight <dbl>
```


```r
bad_guys_bald <- bad_guys %>% 
  filter(hair_color=="No Hair")
bad_guys_bald
```

```
## # A tibble: 35 x 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Abom… Male   green     Huma… No Hair     203   Marvel C… <NA>       bad      
##  2 Abso… Male   blue      Human No Hair     193   Marvel C… <NA>       bad      
##  3 Alien Male   <NA>      Xeno… No Hair     244   Dark Hor… black      bad      
##  4 Anni… Male   green     <NA>  No Hair     180   Marvel C… <NA>       bad      
##  5 Anti… Male   yellow    God … No Hair      61   DC Comics <NA>       bad      
##  6 Blac… Male   black     Human No Hair     188   DC Comics <NA>       bad      
##  7 Bloo… Male   white     <NA>  No Hair      30.5 Marvel C… <NA>       bad      
##  8 Brai… Male   green     Andr… No Hair     198   DC Comics green      bad      
##  9 Dark… Male   red       New … No Hair     267   DC Comics grey       bad      
## 10 Dart… Male   yellow    Cybo… No Hair     198   George L… <NA>       bad      
## # … with 25 more rows, and 1 more variable: weight <dbl>
```
There are more good guys who are bald (37) than bad guys who are bald (35).



10. Let's explore who the really "big" superheros are. In the `superhero_info` data, which have a height over 300 or weight over 450?

```r
superhero_info %>% 
  select(name, height, weight) %>% 
  filter(height>300 | weight>450)
```

```
## # A tibble: 14 x 3
##    name          height weight
##    <chr>          <dbl>  <dbl>
##  1 Bloodaxe       218      495
##  2 Darkseid       267      817
##  3 Fin Fang Foom  975       18
##  4 Galactus       876       16
##  5 Giganta         62.5    630
##  6 Groot          701        4
##  7 Hulk           244      630
##  8 Juggernaut     287      855
##  9 MODOK          366      338
## 10 Onslaught      305      405
## 11 Red Hulk       213      630
## 12 Sasquatch      305      900
## 13 Wolfsbane      366      473
## 14 Ymir           305.      NA
```

11. Just to be clear on the `|` operator,  have a look at the superheros over 300 in height...

```r
superhero_info %>% 
  select(name, height) %>% 
  filter(height>300)
```

```
## # A tibble: 8 x 2
##   name          height
##   <chr>          <dbl>
## 1 Fin Fang Foom   975 
## 2 Galactus        876 
## 3 Groot           701 
## 4 MODOK           366 
## 5 Onslaught       305 
## 6 Sasquatch       305 
## 7 Wolfsbane       366 
## 8 Ymir            305.
```

12. ...and the superheros over 450 in weight. Bonus question! Why do we not have 16 rows in question #10?

```r
superhero_info %>% 
  select(name, weight) %>% 
  filter(weight>450)
```

```
## # A tibble: 8 x 2
##   name       weight
##   <chr>       <dbl>
## 1 Bloodaxe      495
## 2 Darkseid      817
## 3 Giganta       630
## 4 Hulk          630
## 5 Juggernaut    855
## 6 Red Hulk      630
## 7 Sasquatch     900
## 8 Wolfsbane     473
```
We do not have 16 rows in question #10 because there are some superheroes who are both over 300 in height and over 450 in weight, so they are accounted for twice when you add up the results from #11 and #12.


## Height to Weight Ratio
13. It's easy to be strong when you are heavy and tall, but who is heavy and short? Which superheros have the highest height to weight ratio?

```r
superhero_info %>% 
  mutate(height_weight_ratio=height/weight) %>% 
  select(name, height_weight_ratio) %>% 
  arrange(desc(height_weight_ratio))
```

```
## # A tibble: 734 x 2
##    name            height_weight_ratio
##    <chr>                         <dbl>
##  1 Groot                        175.  
##  2 Galactus                      54.8 
##  3 Fin Fang Foom                 54.2 
##  4 Longshot                       5.22
##  5 Jack-Jack                      5.07
##  6 Rocket Raccoon                 4.88
##  7 Dash                           4.52
##  8 Howard the Duck                4.39
##  9 Swarm                          4.17
## 10 Yoda                           3.88
## # … with 724 more rows
```


## `superhero_powers`
Have a quick look at the `superhero_powers` data frame.  

```r
superhero_powers
```

```
## # A tibble: 667 x 168
##    hero_names agility accelerated_hea… lantern_power_r… dimensional_awa…
##    <chr>      <lgl>   <lgl>            <lgl>            <lgl>           
##  1 3-D Man    TRUE    FALSE            FALSE            FALSE           
##  2 A-Bomb     FALSE   TRUE             FALSE            FALSE           
##  3 Abe Sapien TRUE    TRUE             FALSE            FALSE           
##  4 Abin Sur   FALSE   FALSE            TRUE             FALSE           
##  5 Abominati… FALSE   TRUE             FALSE            FALSE           
##  6 Abraxas    FALSE   FALSE            FALSE            TRUE            
##  7 Absorbing… FALSE   FALSE            FALSE            FALSE           
##  8 Adam Monr… FALSE   TRUE             FALSE            FALSE           
##  9 Adam Stra… FALSE   FALSE            FALSE            FALSE           
## 10 Agent Bob  FALSE   FALSE            FALSE            FALSE           
## # … with 657 more rows, and 163 more variables: cold_resistance <lgl>,
## #   durability <lgl>, stealth <lgl>, energy_absorption <lgl>, flight <lgl>,
## #   danger_sense <lgl>, underwater_breathing <lgl>, marksmanship <lgl>,
## #   weapons_master <lgl>, power_augmentation <lgl>, animal_attributes <lgl>,
## #   longevity <lgl>, intelligence <lgl>, super_strength <lgl>,
## #   cryokinesis <lgl>, telepathy <lgl>, energy_armor <lgl>,
## #   energy_blasts <lgl>, duplication <lgl>, size_changing <lgl>,
## #   density_control <lgl>, stamina <lgl>, astral_travel <lgl>,
## #   audio_control <lgl>, dexterity <lgl>, omnitrix <lgl>, super_speed <lgl>,
## #   possession <lgl>, animal_oriented_powers <lgl>, weapon_based_powers <lgl>,
## #   electrokinesis <lgl>, darkforce_manipulation <lgl>, death_touch <lgl>,
## #   teleportation <lgl>, enhanced_senses <lgl>, telekinesis <lgl>,
## #   energy_beams <lgl>, magic <lgl>, hyperkinesis <lgl>, jump <lgl>,
## #   clairvoyance <lgl>, dimensional_travel <lgl>, power_sense <lgl>,
## #   shapeshifting <lgl>, peak_human_condition <lgl>, immortality <lgl>,
## #   camouflage <lgl>, element_control <lgl>, phasing <lgl>,
## #   astral_projection <lgl>, electrical_transport <lgl>, fire_control <lgl>,
## #   projection <lgl>, summoning <lgl>, enhanced_memory <lgl>, reflexes <lgl>,
## #   invulnerability <lgl>, energy_constructs <lgl>, force_fields <lgl>,
## #   self_sustenance <lgl>, anti_gravity <lgl>, empathy <lgl>,
## #   power_nullifier <lgl>, radiation_control <lgl>, psionic_powers <lgl>,
## #   elasticity <lgl>, substance_secretion <lgl>,
## #   elemental_transmogrification <lgl>, technopath_cyberpath <lgl>,
## #   photographic_reflexes <lgl>, seismic_power <lgl>, animation <lgl>,
## #   precognition <lgl>, mind_control <lgl>, fire_resistance <lgl>,
## #   power_absorption <lgl>, enhanced_hearing <lgl>, nova_force <lgl>,
## #   insanity <lgl>, hypnokinesis <lgl>, animal_control <lgl>,
## #   natural_armor <lgl>, intangibility <lgl>, enhanced_sight <lgl>,
## #   molecular_manipulation <lgl>, heat_generation <lgl>, adaptation <lgl>,
## #   gliding <lgl>, power_suit <lgl>, mind_blast <lgl>,
## #   probability_manipulation <lgl>, gravity_control <lgl>, regeneration <lgl>,
## #   light_control <lgl>, echolocation <lgl>, levitation <lgl>,
## #   toxin_and_disease_control <lgl>, banish <lgl>, energy_manipulation <lgl>,
## #   heat_resistance <lgl>, …
```

14. How many superheros have a combination of accelerated healing, durability, and super strength?

```r
superhero_powers %>% 
  filter(accelerated_healing=="TRUE" & durability=="TRUE" & super_strength=="TRUE")
```

```
## # A tibble: 97 x 168
##    hero_names agility accelerated_hea… lantern_power_r… dimensional_awa…
##    <chr>      <lgl>   <lgl>            <lgl>            <lgl>           
##  1 A-Bomb     FALSE   TRUE             FALSE            FALSE           
##  2 Abe Sapien TRUE    TRUE             FALSE            FALSE           
##  3 Angel      TRUE    TRUE             FALSE            FALSE           
##  4 Anti-Moni… FALSE   TRUE             FALSE            TRUE            
##  5 Anti-Venom FALSE   TRUE             FALSE            FALSE           
##  6 Aquaman    TRUE    TRUE             FALSE            FALSE           
##  7 Arachne    TRUE    TRUE             FALSE            FALSE           
##  8 Archangel  TRUE    TRUE             FALSE            FALSE           
##  9 Ardina     TRUE    TRUE             FALSE            FALSE           
## 10 Ares       TRUE    TRUE             FALSE            FALSE           
## # … with 87 more rows, and 163 more variables: cold_resistance <lgl>,
## #   durability <lgl>, stealth <lgl>, energy_absorption <lgl>, flight <lgl>,
## #   danger_sense <lgl>, underwater_breathing <lgl>, marksmanship <lgl>,
## #   weapons_master <lgl>, power_augmentation <lgl>, animal_attributes <lgl>,
## #   longevity <lgl>, intelligence <lgl>, super_strength <lgl>,
## #   cryokinesis <lgl>, telepathy <lgl>, energy_armor <lgl>,
## #   energy_blasts <lgl>, duplication <lgl>, size_changing <lgl>,
## #   density_control <lgl>, stamina <lgl>, astral_travel <lgl>,
## #   audio_control <lgl>, dexterity <lgl>, omnitrix <lgl>, super_speed <lgl>,
## #   possession <lgl>, animal_oriented_powers <lgl>, weapon_based_powers <lgl>,
## #   electrokinesis <lgl>, darkforce_manipulation <lgl>, death_touch <lgl>,
## #   teleportation <lgl>, enhanced_senses <lgl>, telekinesis <lgl>,
## #   energy_beams <lgl>, magic <lgl>, hyperkinesis <lgl>, jump <lgl>,
## #   clairvoyance <lgl>, dimensional_travel <lgl>, power_sense <lgl>,
## #   shapeshifting <lgl>, peak_human_condition <lgl>, immortality <lgl>,
## #   camouflage <lgl>, element_control <lgl>, phasing <lgl>,
## #   astral_projection <lgl>, electrical_transport <lgl>, fire_control <lgl>,
## #   projection <lgl>, summoning <lgl>, enhanced_memory <lgl>, reflexes <lgl>,
## #   invulnerability <lgl>, energy_constructs <lgl>, force_fields <lgl>,
## #   self_sustenance <lgl>, anti_gravity <lgl>, empathy <lgl>,
## #   power_nullifier <lgl>, radiation_control <lgl>, psionic_powers <lgl>,
## #   elasticity <lgl>, substance_secretion <lgl>,
## #   elemental_transmogrification <lgl>, technopath_cyberpath <lgl>,
## #   photographic_reflexes <lgl>, seismic_power <lgl>, animation <lgl>,
## #   precognition <lgl>, mind_control <lgl>, fire_resistance <lgl>,
## #   power_absorption <lgl>, enhanced_hearing <lgl>, nova_force <lgl>,
## #   insanity <lgl>, hypnokinesis <lgl>, animal_control <lgl>,
## #   natural_armor <lgl>, intangibility <lgl>, enhanced_sight <lgl>,
## #   molecular_manipulation <lgl>, heat_generation <lgl>, adaptation <lgl>,
## #   gliding <lgl>, power_suit <lgl>, mind_blast <lgl>,
## #   probability_manipulation <lgl>, gravity_control <lgl>, regeneration <lgl>,
## #   light_control <lgl>, echolocation <lgl>, levitation <lgl>,
## #   toxin_and_disease_control <lgl>, banish <lgl>, energy_manipulation <lgl>,
## #   heat_resistance <lgl>, …
```

## `kinesis`
15. We are only interested in the superheros that do some kind of "kinesis". How would we isolate them from the `superhero_powers` data?

```r
superhero_powers %>% 
  select(hero_names, ends_with("kinesis"))
```

```
## # A tibble: 667 x 10
##    hero_names cryokinesis electrokinesis telekinesis hyperkinesis hypnokinesis
##    <chr>      <lgl>       <lgl>          <lgl>       <lgl>        <lgl>       
##  1 3-D Man    FALSE       FALSE          FALSE       FALSE        FALSE       
##  2 A-Bomb     FALSE       FALSE          FALSE       FALSE        FALSE       
##  3 Abe Sapien FALSE       FALSE          FALSE       FALSE        FALSE       
##  4 Abin Sur   FALSE       FALSE          FALSE       FALSE        FALSE       
##  5 Abominati… FALSE       FALSE          FALSE       FALSE        FALSE       
##  6 Abraxas    FALSE       FALSE          FALSE       FALSE        FALSE       
##  7 Absorbing… FALSE       FALSE          FALSE       FALSE        FALSE       
##  8 Adam Monr… FALSE       FALSE          FALSE       FALSE        FALSE       
##  9 Adam Stra… FALSE       FALSE          FALSE       FALSE        FALSE       
## 10 Agent Bob  FALSE       FALSE          FALSE       FALSE        FALSE       
## # … with 657 more rows, and 4 more variables: thirstokinesis <lgl>,
## #   biokinesis <lgl>, terrakinesis <lgl>, vitakinesis <lgl>
```

16. Pick your favorite superhero and let's see their powers!

```r
superhero_powers %>% 
  filter(hero_names=="Thor") %>% 
  select_if(all_vars(.=="TRUE"))
```

```
## Warning: The `.predicate` argument of `select_if()` can't contain quosures. as of dplyr 0.8.3.
## Please use a one-sided formula, a function, or a function name.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_warnings()` to see where this warning was generated.
```

```
## # A tibble: 1 x 18
##   agility accelerated_hea… durability flight longevity super_strength stamina
##   <lgl>   <lgl>            <lgl>      <lgl>  <lgl>     <lgl>          <lgl>  
## 1 TRUE    TRUE             TRUE       TRUE   TRUE      TRUE           TRUE   
## # … with 11 more variables: super_speed <lgl>, weapon_based_powers <lgl>,
## #   teleportation <lgl>, enhanced_senses <lgl>, magic <lgl>,
## #   element_control <lgl>, reflexes <lgl>, invulnerability <lgl>,
## #   toxin_and_disease_resistance <lgl>, weather_control <lgl>, odin_force <lgl>
```

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.  

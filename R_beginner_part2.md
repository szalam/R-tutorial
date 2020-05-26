### **Learning objectives**

-   Learn how to preprocess data in R for analysis and plotting

### **Content**

-   Data types in R: vector, matrix, dataframe, factor, character
-   Read data from multiple folders
-   Replace/remove missing values
-   Manipulate portion of dataframe
-   Calculate statistics by group
-   Row/column-wise statistics
-   Order dataframe values
-   Reshape dataframe
-   Randomly split data
-   Standardize and normalize data
-   For loop and if/else condition

### **Data types in R**

Vector: Sequence of data. Can be told as 1-dimensional data.

``` r
#Vector
v1 = c(1,2,3,4)
v2 = c('A', 'B', 'C', 'D')

print(v1)
```

    ## [1] 1 2 3 4

``` r
print(v2)
```

    ## [1] "A" "B" "C" "D"

Matrix: 2-dimensional data with row and columns. Data type (or class) of
all the matrix element should be same (numeric, character)

``` r
#Matrix. All values are numeric
m = matrix(1:10, nrow = 5, ncol = 2)
m
```

    ##      [,1] [,2]
    ## [1,]    1    6
    ## [2,]    2    7
    ## [3,]    3    8
    ## [4,]    4    9
    ## [5,]    5   10

Dataframe: 2-dimensional data with row and columns. Data type of
different columns can be different. One column can be numeric and
another can be character.

``` r
#Dataframe. Column 1 and 2 numeric, and column 2 character
c1 = c(1:5)
c2 = c(11:15)
c3 = c('A', 'B', 'C', 'D', 'E')
df = data.frame(c1, c2, c3)
```

List: Similar to 3-dimensional data. For example, a list with two
objects (or lists) can have dataframe in the first list and vector in
the second list. It can store different types of objects in different
list.

``` r
#Lists
l = list()
l[[1]] = df
l[[2]] = v1
str(l)
```

    ## List of 2
    ##  $ :'data.frame':    5 obs. of  3 variables:
    ##   ..$ c1: int [1:5] 1 2 3 4 5
    ##   ..$ c2: int [1:5] 11 12 13 14 15
    ##   ..$ c3: chr [1:5] "A" "B" "C" "D" ...
    ##  $ : num [1:4] 1 2 3 4

Factor: Used to categorize data. Can be integer or character. Factor is
very usefull during categorical plots.

``` r
#lets plot year vs rainfal in loc_A in the original dataframe 'df'
df.mod = df[!is.na(df$loc_A),]
#plot(df.mod$Year,df.mod$loc_A)

#convert the Year column of df into factor
df.mod2 = df.mod
df.mod2$Year = as.factor(df.mod2$Year)
# plot(df.mod2$Year,df.mod2$loc_A)
```

### **Read data from multiple folders**

A commonly used technique to read csv/txt files from different folders
is shown below. Here, we read one .csv file from folder “data1”" and 1
.txt file from folder “data2”.

``` r
fold1 = 'C:/sarfaraz/Project_R_tutorials/R-tutorial/R_beginner_part2_files/data1/'
fold2 = 'C:/sarfaraz/Project_R_tutorials/R-tutorial/R_beginner_part2_files/data2/'

#read csv from folder data1
df1 = read.csv(paste0(fold1,'rainfall_data.csv'))
df2 = read.table(paste0(fold2,'d1.txt'),fill =T)
```

### **Remove/replace missing values**

Here we read a csv file with missing data (which is generally read as
“NA” in R). Then remove/replace NA values.

``` r
#set working directory
setwd('C:/sarfaraz/Project_R_tutorials/R-tutorial/R_beginner_part2_files/data1')

#read rainfal data
df = read.csv('rainfall_data.csv')
summary(df)
```

    ##      Date               Month            Year          loc_A         
    ##  Length:144         Min.   : 1.00   Min.   :1981   Min.   :  0.0393  
    ##  Class :character   1st Qu.: 3.75   1st Qu.:1984   1st Qu.: 11.8359  
    ##  Mode  :character   Median : 6.50   Median :1986   Median : 42.6371  
    ##                     Mean   : 6.50   Mean   :1986   Mean   : 73.8314  
    ##                     3rd Qu.: 9.25   3rd Qu.:1989   3rd Qu.:112.1323  
    ##                     Max.   :12.00   Max.   :1992   Max.   :416.9089  
    ##                                                    NA's   :3         
    ##      loc_B               loc_C         
    ##  Min.   :  0.01092   Min.   :  0.0719  
    ##  1st Qu.:  2.93055   1st Qu.:  5.6136  
    ##  Median : 17.68898   Median : 27.4605  
    ##  Mean   : 34.57416   Mean   : 55.3813  
    ##  3rd Qu.: 50.15615   3rd Qu.: 80.5734  
    ##  Max.   :245.07228   Max.   :342.1296  
    ##  NA's   :3           NA's   :2

``` r
#calculate mean
mean(df$loc_A)
```

    ## [1] NA

``` r
mean(df$loc_A, na.rm = T)
```

    ## [1] 73.83143

``` r
#find ids of NAs for loc_A, loc_B, loc_C
id.na.a = which(is.na(df$loc_A)==T)
id.na.a = which(is.na(df$loc_A)==T)
id.na.a = which(is.na(df$loc_A)==T)

#replace NA with -999
df[id.na.a,4] = -999

#remove rows with NA values in loc_A
df2 = df[-id.na.a,]

#another way to remove rows with NA in a single line
df3 = df[!is.na(df$loc_A),]
```

### **Replace character/numeric**

Replacing character/numeric value is a neccesary is skill. For example,
a data may have spelling mistake (“Californiaa”" instread of
“California”). Here, we will learn how to replace character/numreic
values.

``` r
#set working directory
setwd('C:/sarfaraz/Project_R_tutorials/R-tutorial/R_beginner_part2_files/data1')

#read data and check unique Regions
df.tmp = read.csv('replace_char_num.csv')
unique(df.tmp$Region)
```

    ## [1] "California"  "Ohio"        "Nevada"      "Californiaa"

``` r
#looks like there is a spelling mistake. "Californiaa" should be "California". Lets correct it
df.tmp[df.tmp$Region == 'Californiaa',] = 'California'
unique(df.tmp$Region)
```

    ## [1] "California" "Ohio"       "Nevada"

Using ifelse function can be an efficient way to do the replacing job.

``` r
#here we will replace Region Ohio with Washington. The code replace where region is Ohio, otherwise keep as it is.
df.tmp$Region = ifelse(df.tmp$Region == "Ohio", "Washington", df.tmp$Region)   
unique(df.tmp$Region)
```

    ## [1] "California" "Washington" "Nevada"

The method I showed above are also applicable for numeric values or
signs. For example, you might want to replace numeric values, or signs
like “\#” or “?” or even blank spaces " ". The above codes are extremely
useful for data cleaning and preparation for analysis.

### **Manipulate portion of dataframe**

I will show two ways to select part of a dataframe that follow
user-specified condition. Let us separate data with months 1,3 and 7

``` r
#method 1: identify the indices, then separate
id.tmp = which(df$Month == 1 | df$Month == 3 | df$Month == 7)
df.new1 = df[id.tmp,]

#method 2: using %in% 
mon.tmp = c(1,3,7)
df.new2 = df[df$Month %in% mon.tmp,]
```

Let us multiply 1.5 with all the rainfall in month 2 and 4 that occurred
in loc\_A

``` r
#identify the indices of rows with month 2 and 4
id.tmp = which(df$Month == 2 | df$Month == 4)

#multiply 1.5 with the loc_A column having row id as id.tmp
df[id.tmp,4] = df[id.tmp,4] * 1.5
```

### **Calculate statistics by group**

Let us calculate mean rainfall in all the January months (month = 1).

``` r
#using aggregate function
df.gr1 = aggregate(df[,c(4,5,6)],by = list(df[,2]),FUN = mean,na.rm = T)
head(df.gr1)
```

    ##   Group.1     loc_A     loc_B      loc_C
    ## 1       1  26.42661 59.006145  85.862767
    ## 2       2 202.93061 65.025331 104.953206
    ## 3       3 168.03628 91.019927 136.666929
    ## 4       4 -49.59144 28.554692  45.024609
    ## 5       5  36.71198 10.733013  19.447401
    ## 6       6  17.97584  4.148091   7.806769

### **Row/column-wise statistics**

Calculate mean value of all rows/columns

``` r
#calculate mean along selected columns (here, column 4, 5 and 6)
df.gr2.mean = apply(df[,c(4,5,6)], 2, mean,na.rm = T) # here 2 means column-wise

#also calculate column-wise standard deviation
df.gr2.sd = apply(df[,c(4,5,6)], 2, sd,na.rm=T)

#calculate row-wise mean in selected columns (here, column 4, 5 and 6)
df.gr3 = apply(df[,c(4,5,6)], 1, mean,na.rm = T) # here 1 indicate row
```

``` r
# we can also do this using colMeans() and rowMeans() functions
df.gr2_2 = colMeans(df[,c(4,5,6)], na.rm =T)
df.gr2_2
```

    ##    loc_A    loc_B    loc_C 
    ## 55.74019 34.57416 55.38134

``` r
df.gr3_2 = rowMeans(df[,c(4,5,6)], na.rm =T)
```

### **Order dataframe values**

Let us sort the datframe in ascending/descending order

``` r
#sort in ascending order
df.tmp = df[order(df$loc_A),]
head(df.tmp)
```

    ##           Date Month Year         loc_A      loc_B        loc_C
    ## 88   4/15/1988     4 1988 -1498.5000000 60.2571635  77.04603099
    ## 11  11/15/1981    11 1981  -999.0000000 50.1490205 162.31109130
    ## 49   1/15/1985     1 1985  -999.0000000 28.2914828  26.01976957
    ## 8    8/15/1981     8 1981     0.0393286  0.5085948   0.16317945
    ## 103  7/15/1989     7 1989     0.1020899  0.2536141   0.07192623
    ## 68   8/15/1986     8 1986     0.1706050  0.8371909   0.50209573

``` r
#sort in descending order
df.tmp2 = df[order(-df$loc_A),]

#plot
plot(df$loc_A, ylab = 'Rainfall', xlab = 'Months')
plot(df.tmp$loc_A, ylab = 'Rainfall', xlab = 'Months')
plot(df.tmp2$loc_A, ylab = 'Rainfall', xlab = 'Months')
```

<img src="R_beginner_part2_files/figure-markdown_github/order-1.png" style="display: block; margin: auto;" /><img src="R_beginner_part2_files/figure-markdown_github/order-2.png" style="display: block; margin: auto;" /><img src="R_beginner_part2_files/figure-markdown_github/order-3.png" style="display: block; margin: auto;" />

### **Reshape dataframe**

Dataframe can be reshaped in different ways. I am showing few of them
below,

``` r
#transpose
tr = t(df[,c(4,5,6)]) 
#after transpose dataframe became matrix. to convert to dataframe 
df.t = as.data.frame(tr)
```

Melt dataframe to obtain unique ids. This is specially usefull while
using ggplot

``` r
#melt dataframe. This creates unique ids. we need 'reshape2' package for melt function
library(reshape2)
df.m = melt(df, id = c('Date','Year','Month'))
#all rainfall is moved to a single column 'value' and location names to column 'variable'
head(df.m)
```

    ##        Date Year Month variable      value
    ## 1 1/15/1981 1981     1    loc_A 188.682179
    ## 2 2/15/1981 1981     2    loc_A 124.635979
    ## 3 3/15/1981 1981     3    loc_A 136.694246
    ## 4 4/15/1981 1981     4    loc_A  60.335022
    ## 5 5/15/1981 1981     5    loc_A  46.528754
    ## 6 6/15/1981 1981     6    loc_A   4.081162

### **Randomly splitting data**

A lot of application requires data to be randomly splitted. One of which
is to train a model and another for validation. Here, we split the
dataframe into two groups where the first group has 60% data and the
second has 40%.

``` r
id = sample(2, nrow(df), replace = TRUE, prob = c(0.6, 0.4))

#separate rows where id == 1 and id == 2 in two variables
grp1 = df[id==1,]
grp2 = df[id==2,]

dim(df)
```

    ## [1] 144   6

``` r
dim(grp1)
```

    ## [1] 90  6

``` r
dim(grp2)
```

    ## [1] 54  6

### **Standardize and normalize data**

Standardization: Removing the mean and variability from a data. Mean
becomes 0 and standard deviation 1. Normalization: There are different
ways to normalize a data. Common way is to subtract mean and divide by
the range (maximum - minimum).

``` r
#standardization of rainfall in location A
scale.df= scale(df$loc_A)

#normalize rainfall in location A
nor.locA = (df$loc_A - min(df$loc_A, na.rm = T))/(max(df$loc_A, na.rm = T) - min(df$loc_A, na.rm = T))
```

### **For loop and if/else**

We will read three text files in loop, apply id/else. To do this
download ‘locA.txt’, ‘locB.txt’ and ’locC.txt from my github link.

``` r
#change working directory to the data location
setwd('C:/sarfaraz/Project_R_tutorials/R-tutorial/R_beginner_part2_files/data2/')

#list down files with .txt extension
files = list.files(pattern='.txt')

#total files listed
length(files)
```

    ## [1] 3

Read files in loop and apply if/else condition. I am creating two
examples for this

#### Example 1:

Read texts in loop and print texts if missing value is more than or
equal 9 in a column

``` r
#change working directory to the data location
setwd('C:/sarfaraz/Project_R_tutorials/R-tutorial/R_beginner_part2_files/data2/')

#for loop
for(i in 1:length(files)){ # iterate 3 times
  
  #read txt file. fill = T means the missing value is filled
  df.tmp = read.table(files[i],fill = T,header = T)
  
  if(length(is.na(df.tmp$loc_B)==T)<=9){
    print(paste0('i=',i,' Note:less than or equal 9 missing values'))
  }else{
      print(paste0('i=',i,' Note:more than 9 missing values'))
    }
  }
```

    ## [1] "i=1 Note:less than or equal 9 missing values"
    ## [1] "i=2 Note:more than 9 missing values"
    ## [1] "i=3 Note:less than or equal 9 missing values"

#### Example 2:

Same as the previous example, but skipping a loop when missing value
greater than 9

``` r
#change working directory to the data location
setwd('C:/sarfaraz/Project_R_tutorials/R-tutorial/R_beginner_part2_files/data2/')

#for loop
for(i in 1:length(files)){ # iterate 3 times
  
  #read txt file. fill = T means the missing value is filled
  df.tmp = read.table(files[[i]],fill = T,header = T)
  if(length(is.na(df.tmp$loc_B)==T)<=9){
    print(paste0('i=',i,' Note:less than or equal 9 missing values'))
  }else{
      next()
    }
  }
```

    ## [1] "i=1 Note:less than or equal 9 missing values"
    ## [1] "i=3 Note:less than or equal 9 missing values"

# Learning objectives
# * Install R
# * Learn how to run basic commands


# Content
# * Learn about R and Rstudio
# * Install R and Rstudio
# * RStudio interface
# * Simple commands in the console
# * Write and read excel/text files
# * Select row/column in dataframe
# * Summary statistics
# * Simple plot
# * Install and call libraries
# * First look to ggplot

# What is R?
# R is like any other programming language that is used for statistical computing and graphics. R is an open source tool by R Foundation for Statistical Computing. Learn more about the background of R at <https://www.r-project.org/about.html>.

# What is RStudio?
# RStudio is an integrated development environment (IDE) for R. Where IDE is a software application that provides facilities to run codes, develop softwares and many other things. We will use Rstudio to write/run codes, visualize graphs and do other analysis. Learn more about Rstudio at <https://rstudio.com/about/>

# Install R and RStudio
# Download R first. R for windows can be found here <https://cran.r-project.org/bin/windows/base/>. MAC user can find R here <https://cran.r-project.org/bin/macosx/>. Install R in your machine. Next, download Rstudio from  <https://rstudio.com/products/rstudio/download/>. For personal use, download the free version of Rstudio. Install Rstudio by running the downloaded  executable file.

# RStudio interface
# RStudio IDE consists of numerous options. I find the following cheat sheet nicely summarizes the IDE options available 
# <https://rstudio.com/wp-content/uploads/2016/01/rstudio-IDE-cheatsheet.pdf>

# Simple commands in the console
# RStudio console can be used to write/run codes. Couple of examples are shown below. Run each of the examples in the console. You can see the variables "a" and "b" are stored in the environment panel that is generally located on the right side of RStudio IDE.

## Example 1
# Store single values in variable a and b, then do simple calculations.
a = 5
b = 2
a+b
(a+b)^2


# Example 2
# Create series and store in variable. This is also known as vector. 
a = 1:10 # 1 to 10 at interval 1
print(a)
b = seq(1,22,3) # 1 to 22 at interval 3
print(b)
print(b^2)


## Example 3
# Create 2D data that has rows and columns. It can be dataframe or matrix. Lets now just work with dataframe. Dataframe is a 2D array-like structure that can store  numeric, factor or character type. More about dataframe can be found here <https://www.tutorialspoint.com/r/r_data_frames.htm> 
a = 1:10 
b = 11:20
df = data.frame(col1 = a, col2 = b) # storing a and b as two columns
head(df, 4) # head() is used to see first few lines (here 4) of dataframe

# Write and read excel/text files
# Here we will used an already existing dataset in R to write/read examples. The dataset is stored in the variable "cars", which has two columns: speed and distance. Below, two examples shown where the example 1 shows how to write data in excel/txt format, and example 2 shows how to read those dataset. Before the examples, the following codes can be used to change the working directory, where working directory is the default folder in your computer where exported/imported files are located. 

#setwd() command changes the working directory. Always use / 
setwd('C:/sarfaraz/Project_R_advance/R-tutorial/R_beginner_part1_files/')

#check current directory location using getwd()
getwd()

#to list all the files in the directory
list.files()


## Example 1
head(cars) # check first few lines of cars variable. Here, cars is a default dataset in R.

#check the class of cars
class(cars)

#write into an excel file
write.csv(cars, file = 'cars_example.csv')

#write into text file where the values are separated by comma
write.table(cars, 'cars_example.txt',sep = ",")


## Example 2
#read an excel file
df = read.csv('cars_example.csv')

#read text file. where header = T means the first row is the title of each column. sep specifies what is used in the text to separate columns.
df2 = read.table('cars_example.txt',header = T, sep = ",")
head(df2)


# Select by row/column id in dataframe
#show row 4 of cars. 
a = cars[4,]
print(a)

#show column 1 of cars
b = cars[,1]
print(b)

#can also select by column name
a2 = cars$speed
print(a2)

#show the value with row = 5, colum = 2
c = cars[5,2]
print(c)

#show all with speed > 4
d = cars[cars[,1]>4,]
head(d,5) # show only first 5 rows, there are many more

#show all with speed > 4 and <9
e = cars[cars[,1]>4 & cars[,1]<9,]
print(e)

#show all with speed > 4 and dist<16
f = cars[cars[,1]>4 & cars[,2]<16,]
print(f)

#check the dimension
dim(f) # the first value is row and the second value is column number

# Summary statistics
# Summary of the data can be found using summary() command.
#summarize cars
summary(cars)

#it is also possible to get specific stat. E.g.
mean(cars[,1]) # mean of all values in the first column
median(cars[,2]) # median of all values in second column

# Simple plot
# Simple scatterplot can be obtained using plot() function. For example,
x = cars[,1]
y = cars[,2]
plot(x,y, xlab=c('Speed'), ylab = c('Distance'))

# Install and call libraries
# A lot of the functions used in R is not present by default. We have to install packages and call the required libraries to actually use it. For example, the following code shows how to install and call ggplot2 package.

# install.packages('ggplot2') # uncomment the line to execute it. I am commenting it out as it is already installed in my computer.
# install.packages('dplyr')

#call library
library(ggplot2)
library(dplyr)

# First look to ggplot
# ggplot is an incredibly powerful tool for plotting. It deserves a separate session to go over it. For now, let us plot the cars dataset using ggplot.

p =cars %>% 
  ggplot(aes(x = speed, y = dist))+
  geom_point()

print(p)

#export plot in png format. Image can simply be exported using png() function
png('figure_test1.png')
print(p)
dev.off()

#plots prepared using ggplot can also be exported using ggsave() function
ggsave(p,filename='figure_test2.png',
       width = 20, height = 15, units = "cm")


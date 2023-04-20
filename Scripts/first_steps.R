# to get help
?mean()

#ex:
x <- c(0:10, 50)
xm <- mean(x)
c(xm, mean(x, trim = 0.10))

# to check your working directory
getwd()

# to set working directory
setwd()

# more info about your session
sessionInfo()

# alt and dash = assignment code <-
weight_kg <- 55

weight_lb <- weight_kg * 2.2 


# rounding numbers
weight_kg2 <- sqrt(10)
round(weight_kg2, digits = 0)
round(weight_kg2, digits = 2)

# checking functions arguments
args(round)


# VECTORS AND DATA TYPES
weight_g <- c(50,60,65,82)
animals <- c("mouse", "rat", "dog")

# to check data type
class(animals)

#logical vector
logical_vector <- c(TRUE, TRUE, FALSE, TRUE)

#ex 1.2:

num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")

#character < numerical < logical
class(num_char) 
class(num_logical) 
class(char_logical)
class(tricky)

#to check object structure
str(animals)


# SUBSETTING VECTORS

animals[2]
animals[c(2,3)]
animals[2:3]
animals[-c(2,3)] #filtering
animals[length(animals)] #calling the last one
animals[(length(animals)-1)]


weight_g <- c(21,34,39,54,55)
weight_g[c(TRUE, FALSE, FALSE, TRUE, TRUE)]
weight_g > 50
weight_g[weight_g > 50 & weight_g <30]

# Missing values
height <- c(2,4,4,NA,6)
mean(height)
mean(height, na.rm= TRUE)



#----------------------------------------
setwd("~/R/DataManagement")

download.file(
  url = "https://nbisweden.github.io/module-r-intro-dm-practices/data/Hawks.csv",
  destfile = "Data_Raw/Hawks.csv"
)


hawks <- read_csv("Data_Raw/Hawks.csv")

spec(hawks) # To check colums specs

#Exercise 2


#Size
dim(hawks)
nrow(hawks)    
ncol(hawks)

#Content
head(hawks)
tail(hawks)

#Names
names(hawks)
rownames(hawks)

#Summary
str(hawks)
summary(hawks)

#Subsetting
hawks[3,10]
hawks[10]
hawks[3:4,10:16]
hawks$Wing



#Based on the output of str(hawks), can you answer the following questions?
#What is the class of the object hawks?  a: data.frame tibble
#How many rows and how many columns are in this object? a: 908 rows, 19 columns



#Create a data.frame (hawks_20) containing only the data in row 20 of the hawks dataset.

hawks_20 <- hawks[20,]

#Notice how nrow() gave you the number of rows in a data.frame?
  
#Use that number to pull out just that last row in the data frame.
#Compare that with what you see as the last row using tail() to make sure it’s meeting expectations.
#Pull out that last row using nrow() instead of the row number.
#Create a new data frame (hawks_last) from that last row.
#Combine nrow() with the - notation above to reproduce the behavior of head(hawks), keeping just the first 6 rows of the hawks dataset.

# Selecting data with tidyverse

# Useful dplyr functions
#   select(): subset columns
#   filter(): subset rows on conditions
#   mutate(): create new columns by using information from other columns
#   group_by() and summarize(): create summary statistics on grouped data
#   arrange(): sort results
#   count(): count discrete values

select(hawks, Species, Sex, Weight)

select(hawks, -Species, -Sex, -Weight) # avoiding columns with minus

drop_na(hawks, Sex, Weight)
drop_na(hawks)

filter(hawks, Sex == "F")


hawks_female <- filter(hawks, Sex == "F")
hawks_female_sml <-  select(hawks_female, Species, Sex, Weight)

# Pipes ctrl + shift + M

filter(hawks, Sex == "F") %>%
  select(Species, Sex, Weight)



#Challenge 3.1

# Using pipes, subset the hawks data to include only 
#   males with a weight (column Weight) greater than 500 g, 
#     and retain only the columns Species and Weight.

hawks %>% 
  filter(Sex == "M") %>%
  filter(Weight > 500) %>%
  select (Species, Weight) 


# Modifying data with mutate()

hawks %>% 
  mutate(Weight_KG = Weight / 1000)


hawks %>% 
  mutate(Weight_KG = Weight / 1000,
         Weight_lb = Weight_KG * 2.2)


# Create a new data frame from the hawks data that meets the following criteria:
#   contains only the Species column and a new column called Tarsus_cm 
#   containing the Tarsus values (currently in mm) converted to centimeters.
#   Furthermore, the Tarsus_cm column should have no NAs and all values must be less than 6 cm.
#   Hint: think about how the commands should be ordered to produce this data frame!

hawks %>% 
  drop_na(Tarsus) %>% 
  mutate(Tarsus_cm = Tarsus / 10) %>% 
  select(Species, Tarsus_cm) %>% 
  filter(Tarsus_cm < 6)

# HINT: ctrl + shift + C  will remove the line/lines by inserting # and space

kg_to_lb(95)
kg_to_lb(c(48,90,95,85))


# Challenge 3.3
#   Use the function kg_to_lb() above to create a new column in the hawks data frame 
#   with the body weight expressed in pounds.

hawks %>% 
  mutate(Weight_lb = kg_to_lb(Weight))

# combining dataframes

hawks %>% 
  group_by(Sex) %>% 
  summarize(mean = mean(Weight, na.rm = TRUE))


hawks %>% 
  group_by(Species, Sex) %>% 
  summarize(mean = mean(Weight, na.rm = TRUE),
            min = min(Weight, na.rm = TRUE))


large_birds_counts <- hawks %>%
  filter(Weight > 500) %>% 
  count(Species, Sex)

# Exporting data

write_csv(large_birds_counts, 
          "data_processed/large-birds_counts.csv")


# Data visualization with ggplot2

# ggplot(data = <DATA>, mapping = aes(<MAPPINGS>)) +  <GEOM_FUNCTION>() + ...

ggplot(hawks, mapping = aes(x = Weight, y = Wing))



ggplot(hawks, mapping = aes(x = Weight, y = Wing)) + 
  geom_point()


ggplot(hawks, mapping = aes(x = Weight, y = Wing)) + 
  geom_point(alpha=0.2, color= "blue")


ggplot(hawks, mapping = aes(x = Weight, y = Wing)) + 
  geom_point(alpha=0.2, aes(color = Species))


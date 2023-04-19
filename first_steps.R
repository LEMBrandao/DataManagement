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

# Set working directory
setwd("C:/Users/Euclides/Documents/GitHub/R_Programing_Workshop/")

# Basic operations
4+4
4*4
4/4
4-3

# Assigning objects

x <- 10 
y <- 50
x + y
x /y
y/ x+x
y/(x+x)

z <- c(10, 15,11,50,5)
z + y
z + z
z * z
z - x

# Creating your first function

average <- function(x){
  sum(x)/length(x)
}

average(x = z)
mean(z)
sum(z)
sqrt(z)
quantile(z)
summary(z)
median(z)

# Creating qualitative variables
names <- c( "Euclides", "Sajedeh", "Maegan", "Cassidy" )
average(x = names) # gives an error 

ses <- c('below poverty', "average", "upper", 'average', "below poverty")
ses <- factor(ses) # assigns ordinal levels to qualitative variables
levels(ses)
ses <- factor(ses, levels = c('below poverty', "average", "upper"))
levels(ses)

# Logical Vectors

l <- c(TRUE, TRUE, FALSE, FALSE, TRUE)
l == l
l != l
z > y
y > z
names == "Euclides"

# Selecting elements
z[z>10]
z[z==10]

# "<-" and "=" are the same thing 
z[z>=10]
z[1:3]
# Sequence of number
1:16
seq(1, 16)

my_matrix <- matrix(data = 1:16, nrow = 4, ncol = 4 )
my_matrix[ 1:2, ] # selecting rows

my_matrix[ , 1:2] # selecting cols
my_matrix[ , c(1,4)] # selecting cols 1 and 4
my_matrix[ , 1:4]

View(my_matrix)

# Create a dataframe

my_dataframe <- data.frame( names = c("Euclides", 'Maegan', "Vlad"),
                            gender= c("Man", "Woman", "Man"),
                            age = c(34, 26, 26)
                            )
# Selecting a variable
my_dataframe[,3]
my_dataframe[,"age"]
my_dataframe$age

mean(my_dataframe$age)
median(my_dataframe$age)
sd(my_dataframe$age)

# Select cases (rows)
my_dataframe[1:2 ,]
my_dataframe[c(1,3) ,]
my_dataframe[ my_dataframe$gender == "Man", ]

my_dataframe[c(1,3), c(1,3) ]



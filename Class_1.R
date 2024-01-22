# Set working directory
setwd("ADDD YOUR  PATH HERE")
getwd() #Check your work directory path

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

# Adding a variable
my_dataframe$height <- c(181, 164, 176)
my_dataframe[ ,"height" ] <- c(181,164,176)

my_dataframe$Ratio <- my_dataframe$height / my_dataframe$age # Ratio between height and age
colnames(my_dataframe)

# Installing and starting packages
install.packages("haven")   # For reading SPSS files
install.packages("ggplot2") # For making amazing graphs
install.packages("psych")   # For descriptives

# Activating packages
library(haven)
student.heights <- read_spss(file = "C:/Users/Euclides/Documents/GitHub/R_Programing_Workshop/Undergraduate_anthropometric.sav")
student.heights <- read_spss(file = "Undergraduate_anthropometric.sav")
student.heights <- as.data.frame(student.heights)

colnames(student.heights)

student.heights.m <- student.heights [ student.heights$sex == "masculino" , ]
student.heights.f <- student.heights [ student.heights$sex == "feminino" , ]

# Recoding sex variable

student.heights$sex <- ifelse( student.heights$sex == "masculino",
                               yes = "Males",
                               no = "Females"
                               )

student.heights$height_cat <- ifelse( student.heights$height > median(student.heights$height),
                                      yes = "Tall",
                                      no = "Short" 
                                      )

student.heights.m <- student.heights [ student.heights$sex == "Males" , ]
student.heights.f <- student.heights [ student.heights$sex == "Females" , ]

student.heights[, c( "height", "fathers_height", "mother_height")]

class(student.heights)
mean(student.heights[, c( "height", "fathers_height", "mother_height")])
mean( student.heights[, "height"] )
apply(X = student.heights[, c( "height", "fathers_height", "mother_height")],
      MARGIN = 2,
      FUN = mean)

# Reading the psych package
library(psych)
install.packages("psych", dependencies = TRUE)

# Get descriptives
describe(x = student.heights[,c("height", "fathers_height", "mother_height")])

# Basic R graphs ####
hist(x = student.heights$height,
     xlab = "Student height (cm)",
     main = "Distribution",
     breaks = 20,col = "#a65fc9")

plot(y= student.heights$height,x= student.heights$fathers_height,
     xlab = "Father's height (cm)",
     ylab= "Students' height (cm)",pch=0
     )

boxplot(student.heights$height ~student.heights$sex,
        xlab =  "Sex",
        ylab = "Height in cm",
        col="lightblue"
          )

boxplot(student.heights$height ~student.heights$height_cat,
        xlab =  "Group",
        ylab = "Height in cm",
        col="lightblue"
)

# Install.package
install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)

chart.Correlation(
  student.heights[,c("height", "sexo_dummy", "fathers_height", "mother_height") ]
  )

# Saving the dataset ####
write_sas(data = student.heights, path = "Undergraduate_anthropometric_updated.sav")





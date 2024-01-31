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

####################
#### Session 2 ####
##################

install.packages("ggplot2")
library(ggplot2)

install.packages("rcompanion")
library(rcompanion) # used for obtaining standard errors and adjusted means

library(psych)

install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)

install.packages("ggsignif")
library(ggsignif)

# Set the working directory
setwd("C:/Users/Euclides/Desktop/GSAP_Workshop/R_Programing_Workshop/")
getwd()

# Load dataset

wm <- read.csv("Working_memory.csv")
wm <- read.csv("https://github.com/euclidesmendonca/R_Programing_Workshop/raw/main/Working_memory.csv")

library(haven)
heights <- read_spss("Undergraduate_anthropometric.sav")

plot(heights$height ~ heights$mother_height)

#### Grammar of Graphics - GGPLOT2 #####

jpeg(filename = "My_scatter_Plot.jpeg",
     width = 12,
     height = 5*2,
     units = "cm",
     res = 450)

ggplot(data = heights, aes(x=mother_height, y= height)) +
  geom_point() +
  theme_bw()   +
  labs(title = "My scatter plot",
       subtitle = "Height in centimeters",
       x= "Mother's height",
       y = "Students' height"
       )+
  theme(axis.title = element_text(hjust = .5),
        plot.title = element_text(hjust = .5) )+
  geom_smooth(method = 'lm' )

dev.off() # This tells R to end the graph device

# Saving PDF
pdf(file = "My_Scatter_Plots.pdf", width = 12, height = 10, onefile = TRUE)
ggplot(data = heights, aes(x=mother_height, y= height)) +
  geom_point() +
  theme_bw()   +
  labs(title = "My scatter plot",
       subtitle = "Height in centimeters",
       x= "Mother's height",
       y = "Students' height"
  )+
  theme(axis.title = element_text(hjust = .5),
        plot.title = element_text(hjust = .5) )+
  geom_smooth(method = 'lm' )


ggplot(data = heights, aes(x=sex, y= height)) +
  geom_boxplot() +
  geom_point()+
  geom_jitter()+
  theme_bw()  

dev.off()

# Exploring Boxplots and distributions

ggplot(data = heights, aes(x=sex, y= height, fill = sex)) +
  geom_boxplot() +
  geom_point()+
  geom_jitter()+
  theme_bw()

# Recoding the sex variable
heights$sex <- ifelse( heights$sex == "masculino",
                   yes = "Males",
                   no = "Females"
                   )

ggplot(data = heights, aes(x=sex, y= height, fill = sex)) +
  geom_boxplot() +
  geom_point()+
  geom_jitter()+
  theme_bw()

ggplot(data = heights, aes(x=sex, y= height, fill = sex)) +
  geom_violin() +
  geom_point()+
  geom_jitter()+
  theme_bw()+
  theme(legend.position = c( .2, .85 ) )+
  scale_fill_manual(values = c('#cf463c', '#42789e'))

# Creating Bar graphs with standard errors

ggplot(data = heights, aes(x=sex, y= height, fill = sex))+
  geom_bar(stat = "summary")+
  theme_bw()+
  theme(legend.position = c( .2, .85 ) )+
  scale_fill_manual(values = c('#cf463c', '#42789e'))+
  coord_cartesian( ylim = c(50, 200 ) )

ggplot(data = heights, aes(x=sex, y= height, fill = sex))+
  geom_bar(stat = "summary")+
  theme_bw()+
  theme(legend.position = c( .2, .85 ) )+
  scale_fill_manual(values = c('#cf463c', '#42789e'))+
  ylim(c(50, 200 )) # Not advisable because it removes data points

# Bar graphs with  standard errors
library(rcompanion)
descriptive_stats <- groupwiseMean( height ~ sex, data = heights )
descriptive_stats

ggplot(data = descriptive_stats, aes(x = sex, y = Mean, fill=sex ))+
  geom_bar(stat = 'identity', alpha = .40)+
  geom_errorbar(aes( ymin= Trad.lower, ymax =  Trad.upper), width = .1)+
  coord_cartesian(ylim = c(100 ,200))+
  theme_bw()+
  theme(legend.position = c(.15, .85))+
  scale_fill_manual(values = c('#cf463c', '#42789e'))+
  geom_point(data = heights,
             aes(x= sex, y = height),
             position = position_jitter(.1)
             )

########################
#### Linear Models ####
######################

psych::describeBy( heights$height, group = heights$sex)


fit.height <-  lm(formula =  height ~ sex, data = heights )
summary(fit.height)

ggplot(data = heights, aes(x = sexo_dummy , y = height))+
  geom_point()+
  geom_smooth(method = 'lm')

162.5556 + 15.7958
  
t.test( height ~ sex , data = heights, var.equal=TRUE)
  
# Add covariables - multiple regression

fit.height2 <- lm(formula = height ~ sex + mother_height, data=heights)
summary(fit.height2)

fit.height3 <- lm(formula = height ~ sex + mother_height + fathers_height,
                  data=heights)
summary(fit.height3)


fit.height.males <- lm(formula = height ~ mother_height ,
                       data= heights[ heights$sex == "Males", ] )
summary(fit.height.males)

fit.height.females <- lm(formula = height ~ mother_height ,
                         data=heights[ heights$sex == "Females", ])
summary(fit.height.females)

ggplot(data = heights, aes(x = mother_height, y = height))+
  geom_point()+
  geom_smooth(method='lm')+
  facet_wrap(~sex)

# Testing the interaction between sex and mother's height
fit.height.interact <- lm(formula = height ~ sex + mother_height + sex : mother_height,
                          data= heights  )

fit.height.interact <- lm(formula = height ~ sex * mother_height,
                          data= heights  )

summary(fit.height.interact)
anova(fit.height.interact)

# Executive Function Dataset
colnames(wm)

fit.IQ <- lm ( IQ ~ Exp.group, data = wm)
summary(fit.IQ)

ggplot(data=wm, aes(x = Exp.group, y = IQ))+
  geom_boxplot()+
  geom_point()

# Checking if Working memory is protective of threat condition

fit.IQ.mod <- lm ( IQ ~ Exp.group * Working.memory, data = wm)

ggplot(data = wm, aes( x = Working.memory, y = IQ, col = Exp.group ))+
  geom_point()+
  geom_smooth(method = 'lm')

summary(fit.IQ.mod )
  
library(interactions)
interactions::sim_slopes(fit.IQ.mod, pred = Working.memory, modx = Exp.group)

ggplot(data = wm, aes( x = Working.memory, y = IQ, col = Exp.group ))+
  geom_point()+
  geom_smooth(method = 'lm')+
  theme_bw()+
  theme(legend.position = c(.15, .85))+
  annotate(geom = 'text', x = 140, y = 60,label= "b = .59, p<.001" )+
  annotate(geom = 'text', x = 140, y = 110,label= "b = .12, p = 0.34" )

cor.test(wm[wm$Exp.group == 'control',]$IQ,
         wm[wm$Exp.group == 'control', ]$Working.memory) 

cor.test(wm[wm$Exp.group == 'threat1',]$IQ,
         wm[wm$Exp.group == 'threat1', ]$Working.memory) 

ggplot(data = wm, aes( x = Working.memory, y = IQ, col = Exp.group ))+
  geom_point()+
  geom_smooth(method = 'lm')+
  theme_bw()+
  theme(legend.position = c(.15, .85))+
  annotate(geom = 'text', x = 140, y = 60,label= "r = 0.72, p<.001" )+
  annotate(geom = 'text', x = 140, y = 110,label= "r = 0.10, p = 0.45" )

# Running an anova would look like this
fit.aov <- lm( IQ ~ Exp.group, data = wm)
anova(fit.aov)










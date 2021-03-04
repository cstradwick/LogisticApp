######################
### Generated Data ###
######################

# Generate independent/predictor variables
set.seed(12345)
coffee = sample(c(0,1), size = 1000, replace = T)
hours = rnorm(1000, mean = 6, sd = 1.3)
age = round(runif(1000, 17, 25))
enjoy = sample(c(0,1), size = 1000, replace = T, prob = c(.25,.75))

# Create log odds of falling asleep; use sigmoid function to calculate probability of falling asleep
logodds = 40.8 - 3*coffee - 2*hours - 1.3*age -2*enjoy
p = 1/(1+exp(-logodds))

# Generate binary dependent variable based on probabilities calculated above 
set.seed(12345)
asleep = rbinom(1000, size = 1, prob = p) ; table(asleep)
View(cbind(coffee,hours,age,enjoy,p,asleep))

# Fit a logistic regression model to the generated data
m = glm(asleep ~ coffee + hours + age + enjoy, family = "binomial")
summary(m)
coef <- coefficients(m)

# Use these commands to save the generated data as a CSV and save model as an R object
# Commented out so they are not run on accident
# (Be sure to change "file = " arguments so you don't write over files you would like to keep)

#write.csv(cbind(coffee,hours,age,enjoy,p,asleep), row.names = F, file = "sleep.csv")
#save(m,file="m_asleep.RData")

#############################################################################

#################
### From File ###
#################

#Read in example data table and its logistic model 
data <- read.csv("sleep.csv")
load("m_asleep.RData")
summary(m)
coef <- coefficients(m)


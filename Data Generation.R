### Generate Data

set.seed(12345)
coffee = sample(c(0,1), size = 1000, replace = T)
hours = rnorm(1000, mean = 6, sd = 1.3)
age = round(runif(1000, 17, 25))
enjoy = sample(c(0,1), size = 1000, replace = T, prob = c(.25,.75))

logodds = 40.8 - 3*coffee - 2*hours - 1.3*age -2*enjoy
p = 1/(1+exp(-logodds))

set.seed(12345)
asleep = rbinom(1000, size = 1, prob = p) ; table(asleep)
View(cbind(coffee,hours,age,enjoy,p,asleep))

#write.csv(cbind(coffee,hours,age,enjoy,p,asleep), row.names = F, file = "sleep.csv")

#############################################################################


data <- read.csv("sleep.csv")
m = glm(asleep ~ coffee + sleep + age + enjoy, family = "binomial")
summary(m)
coef <- coefficients(m)
#save(m,file="m_asleep.RData")

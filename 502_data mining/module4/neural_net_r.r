#using a neural network in R 
#use the framingham_train data 
train <- read.csv("#")

train$Death <- as.factor(train$Death)
train$Sex <- as.factor(train$Sex)

#min max standardization required 
train$age.mm <- (train$age -min(train$age)) / (max(train$age)-min(train$age))

#install nnet and neuralNetTools packages 
install.packages("nnet")
install.packages("NeuralNetTools")

library(nnet)
library(NeuralNetTools)

#run
#size = 1: one unit in the hidden layer 
nnet01<- nnet(Death ~ Sex + age.mm, data=train,size=1)

#save output 
plotnet(nnet01)

#get weights 
nnet01$wts 


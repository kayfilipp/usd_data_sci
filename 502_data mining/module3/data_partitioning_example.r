#partition data in R 
set.seed(7) #this is arbitrary, but we need a random number gen

#dataset 
bank = read.csv(".csv")

#get number of rows 
n <- dim(bank)[1]

#determine which records go in our training set 
#here, about 75% will go into our training set 
train_ind <- runif(n) < 0.75 

bank_train <- bank[train_ind,]
bank_test  <- bank[!train_ind,]


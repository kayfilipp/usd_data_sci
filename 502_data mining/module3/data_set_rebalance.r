#balancing a dataset using R 

table(bank_train$response) #check which variable needs to be rebalanced 
						   #assume n = 3103 with yes = 336 (11%)
						   #assume we want 30% 
						   
#formula:
#x = 0.3(3103)-336 / 0.7 = 850 

to.resample<- which(bank_train$response=='yes') #get row numbers that correspond to cond 
our.resample<- sample(x=to.resample, size=850, replace=TRUE)

our.resample <- bank_train[our.resample,]
train_bank_rebal <- rbind(bank_train,our.resample)

#confirm:
t.v1 <- table(train_bank_rebal$response)
t.v2 <- rbind(t.v1, round(prop.table(t.v1), 4))
colnames(t.v2) <- c("Response = No", "Response = Yes");
rownames(t.v2) <- c("Count", "Proportion")
t.v2

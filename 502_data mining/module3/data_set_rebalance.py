#balancing training data in python 
#assume some dataset bank_train with our training data 

bank_train['response'].value_counts() #<- identify how many records have the less common value 

#assume our yes count = 338 for n = 3089 and we want the rate of rare to be 30%
#formula: x = 0.3(3089)-338 / 0.7 = 841 
#we need to add 841 records. 

to_resample <- bank.train.loc[bank_train['response']=='yes']
our_resample <- to_resample.sample(n=841,replace=True)
bank_train_rebal <- pd.concat([bank_train,our_resample])

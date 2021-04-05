file_dir = "C:/Users/Filipp/Documents/usd_data_sci/502_data mining/module1/Website Data Sets"
setwd(file_dir)

#get test and train datasets 
train = read.csv("adult_ch6_training")
test  = read.csv("adult_ch6_test")

#we're going to use marital status and cap losses to predict income.
#first, we get the distribution of income. 
barplot(table(train$Income)/nrow(train))

#change to factors:
test$Marital.status = factor(test$Marital.status)
test$Income         = factor(test$Income)

#install.packages(c("rpart", "rpart.plot"))
library(rpart)
library(rpart.plot)

cart01 <- rpart(formula = Income ~ Marital.status + Cap_Gains_Losses,data = test, method = "class")
rpart.plot(cart01)

                                                                # entropy <- function(a,b){
                                                                #   
                                                                #   if (a==0 & b==0){return(0)}
                                                                #   if (a * b == 0){return(0)}
                                                                #   
                                                                #   a1 = a/(a+b)
                                                                #   b1 = b/(a+b)
                                                                #   e = ((a1*log2(a1)) + (b1*log2(b1))) * -1
                                                                #   
                                                                #   return (e)
                                                                #   
                                                                # }
                                                                # 
                                                                # E_MAIN = entropy(4,5)
                                                                # 
                                                                # 
                                                                # x = (2/9) * entropy(1,1) + (7/9) * entropy(3,4)
                                                                # y = ((3/9) * entropy(2,1)) + (6/9) * entropy(2,4)
                                                                # z = (5/9) * entropy(2,3) + (4/9) * entropy(2,2)
                                                                # w = (6/9) * entropy(3,3) + (3/9) * entropy(1,2)
                                                                # v = (8/9) * entropy(4,4) + (1/9) * entropy(0,1)

#CREATING A C5 MODEL 

install.packages("C50")
library(C50)
C5 <- C5.0(formula = Income ~ maritalStatus + Cap_Gains_
           Losses, data = adult_tr,
           control = C5.0Control(minCases=75)) #requires all terminal nodes to have at least 75 cases.
plot(C5)

predict(object = C5, newdata = X)




#load in our dataset and adjust corrupted column headers 
library(ROCR)
setwd("C:/Users/Filipp/Documents/usd_data_sci/502_data mining/module3")
df = read.csv("question_16_data.csv")
names(df)[1] = "models"
#calculate ROC curves for each model 
df.1 <- subset(df,df$models=="m1")
pred <- prediction(df.1$predictions,df.1$labels)
perf.1 <- performance(pred,"tpr","fpr")
#..
df.2 <- subset(df,df$model=="m2")
pred <- prediction(df.2$predictions,df.2$labels)
perf.2 <- performance(pred,"tpr","fpr")
#co-plot in the same frame.
par(mfrow=c(1,2))
plot(perf.1,main="Model 1 ROC",col="blue",lwd=2)
plot(perf.2,main="Model 2 ROC",col="green",lwd=2)
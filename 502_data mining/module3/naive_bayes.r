#NAIVE BAYES IN R

#assume wine_tr and wine_test have been read in
#make a contingency table for alcohol
ta <- table(wine_tr$Type,wine_tr$Alcohol_flag)
colnames(ta) <- c("Alcohol High","Alcohol Low")
rownames(ta) <- c("Type Red","Type White")
addmargins(A=ta,FUN=list(Tota=sum),quiet=TRUE)

#do the same for sugar flag 
ta <- table(wine_tr$Type,wine_tr$Sugar_flag)
colnames(ta) <- c("Sugar High","Sugar Low")
rownames(ta) <- c("Type Red","Type White")
addmargins(A=ta,FUN=list(Tota=sum),quiet=TRUE)

install.packages("gridExtra"); library(gridExtra)

plot1 <- ggplot(wine_tr, aes(Type)) + geom_bar( aes(fill =Alcohol_flag), position = "fill") +ylab("Proportion")
plot2 <- ggplot(wine_tr, aes(Type)) + geom_bar( aes(fill =Sugar_flag), position = "fill") + ylab("Proportion")
grid.arrange(plot1, plot2, nrow = 1)

install.packages("e1071"); library(e1071)

nb01 <- naiveBayes(formula = Type ~ Alcohol_flag + Sugar_flag, data = wine_tr)
nb01 

ypred <- predict(object = nb01, newdata = wine_test)

t.preds <- table(wine_test$Type, ypred)
rownames(t.preds) <- c("Actual: Red", "Actual: White")
colnames(t.preds) <- c("Predicted: Red", "Predicted: White")
addmargins(A = t.preds, FUN = list(Total = sum), quiet = TRUE)
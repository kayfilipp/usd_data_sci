#LOGISTIC REGRESSION IN R 
#assume we have a dataset containing 
#sales, days, web, CC, etc. as in the python script.

logreg01 <- glm(formula = CC ~ Days + Web, data = sales_
train, family = binomial)

summary(logreg01)

#validation
logreg01_test <- glm(formula = CC ~ Days + Web, data =
sales_test, family = binomial)
summary(logreg01_test)

#prediction
predict(logreg01,data=test,type='response')
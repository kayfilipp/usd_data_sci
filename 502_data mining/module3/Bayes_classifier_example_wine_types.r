#8.5 Application of Naive Bayes Classification
#wine_flag_training and wine_flag_test 

#get datasets
setwd("C:/Users/Filipp/Documents/usd_data_sci/502_data mining/module1/website data sets")
train = read.csv("wine_flag_training.csv")
test  = read.csv("wine_flag_test.csv")

#we want to predict whether a wine is white or red based 
#on alcohol and sugar content. 
#our response is type.

#50-50 split. p(type=red)=p(type=white) = 0.5
table(train$Type)

#get the distribution for alcohol content. p(alcohol_flag=High)=.486
table(train$Alcohol_flag)

#get the dsitribution for sugar content. p(sugar = high) = 0.416
table(train$Sugar_flag)

#get the contingency table for our response variable and our alcohol content.
#alcohol flag doesn't seem to make a difference.
table(data.frame(train$Type,train$Alcohol_flag))

#do the same with our sugar content 
#red wines tend to have a lower sugar content.
#white wines tend to have a higher sugar content.
table(data.frame(train$Type,train$Sugar_flag))

#we can start calculating conditional probabilities for each 
#predictor variable given the target variable 

p_type_red   = length(which(train$Type=="Red"))/nrow(train) 
p_type_white = length(which(train$Type=="White"))/nrow(train) 
p_alc_low    = length(which(train$Alcohol_flag=="Low"))/nrow(train) 
p_alc_high   = 1 - p_alc_low 
p_sugar_low  = length(which(train$Sugar_flag=="Low"))/nrow(train) 
p_sugar_high = 1 - p_sugar_low 

p_alc_high_type_red = length(which(train$Alcohol_flag=="High" & train$Type=="Red")) / length(which(train$Type=="Red"))
p_alc_low_type_red  = 1 - p_alc_high_type_red
p_alc_high_type_white = length(which(train$Alcohol_flag=="High" & train$Type=="White")) / length(which(train$Type=="White"))
p_alc_low_type_white = 1 - p_alc_high_type_white

#we do the same with sugar content:

p_sugar_high_type_red = length(which(train$Sugar_flag=="High" & train$Type=="Red")) / length(which(train$Type=="Red"))
p_sugar_low_type_red  = 1 - p_sugar_high_type_red
p_sugar_high_type_white = length(which(train$Sugar_flag=="High" & train$Type=="White")) / length(which(train$Type=="White"))
p_sugar_low_type_white = 1 - p_sugar_high_type_white

print(c(p_alc_high_type_red,p_alc_low_type_red,p_alc_high_type_white,p_alc_low_type_white))
print(c(p_sugar_high_type_red,p_sugar_low_type_red,p_sugar_high_type_white,p_sugar_low_type_white))

#now that we all have all class conditional probabilities, we can calculate the probability of each wine type 
#notate as follows:
#p(Y=y1 | X*) = p(Red|alcohol_flag=low, sugar_flag=low)
#P(Y=y2 | X*) = p(White|alcohol_flag=low, sugar_flag=low)

#in this instance, our bayes theorem is:
# [p(alc=low|red) * p(sugar=low|red) * p(red)] / [p(alc=low)*p(sugar=low)]
# [p(alc=low|white) * p(sugar=low|white) * p(white) / p(alc=low)*p(sugar=low)]


#calculate the needed probabilities
y1 = p_alc_low_type_red * p_sugar_low_type_red * p_type_red / (p_alc_low * p_sugar_low)
y2 = p_alc_low_type_white * p_sugar_low_type_white * p_type_white / (p_alc_low * p_sugar_low)

c(y1,y2)
#conclusively, a wine with low sugar and alcohol content is far more likely to be red than white.

#we can replicate this computation by looking at high sugar and alcohol content 
z1 = p_alc_high_type_red * p_sugar_high_type_red * p_type_red / (p_alc_high * p_sugar_high)
z2 = p_alc_high_type_white * p_sugar_high_type_white * p_type_white / (p_alc_high * p_sugar_high)
c(z1,z2)

# it is far more likely for a high sugar/alcohol wine to be white.







#FOIL information gain for a RIPPER ruleset 
#to tell the information gain between r0 and r1 using binary/negative instances 

FOIL_information_gain <- function(p0,n0,p1,n1){
  
  sum_0 = p0+n0
  sum_1 = p1+n1
  
  return( p1 * ( log2(p1/sum_1) - log2(p0/sum_0)))
  
}

#test = 8
FOIL_information_gain(100,400,4,1)

#another test case
setwd("C:/Users/Filipp/Documents/usd_data_sci/502_data mining/module3")
df = read.csv("info_gain_example.csv")

#rule_zero: R{}->mammals 
r0_coverage = nrow(df)
r0_accuracy = nrow(df[df$Class=="mammals",])/nrow(df)
print(c(r0_accuracy,r0_coverage))

#proposed rule_one(s):
#skin cover=hair
#body temp = warm
#has legs = no 

#skin cover = hair 
r11_set = subset(df,df$Skin.cover=="hair")
p11 = nrow(subset(r11_set,Class=="mammals"))
n11 = nrow(r11_set) - p11 

#body temp = warm 
r12_set = subset(df,df$Temp == "warmblooded")
p12 = nrow(subset(r12_set,Class=="mammals"))
n12 = nrow(r12_set) - p12 

#has legs = no 
r13_set = subset(df,df$Legs == "no")
p13 = nrow(subset(r13_set,Class=="mammals"))
n13 = nrow(r13_set) - p13 

print(c(p11,n11))
print(c(p12,n12))
print(c(p13,n13))

#r0 has p0=5, n0=10
rule_gains <- c(FOIL_information_gain(5,10,p11,n11),
FOIL_information_gain(5,10,p12,n12),
FOIL_information_gain(5,10,p13,n13)
)

min(rule_gains)
max(rule_gains)
#we pick rule 2.

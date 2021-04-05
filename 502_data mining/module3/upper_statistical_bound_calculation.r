#function to get the upper bound of error rate 
#using an normal distribution 
​
get_CI <- function(N,e,alpha){
  
  Z = qnorm(1-(alpha/2))
  Z2= Z**2
  
  numerator1 = (e + (Z2/(2*N)) + Z*sqrt(((e*(1-e))/N) + (Z2/(4*(N**2)))))
  numerator2 = (e + (Z2/(2*N)) - Z*sqrt(((e*(1-e))/N) + (Z2/(4*(N**2)))))
  denominator = (1 + (Z2/N))
  UB = numerator1/denominator
  LB = numerator2/denominator 
  return (c(LB,UB))
}
get_CI(100,0.8,0.05)
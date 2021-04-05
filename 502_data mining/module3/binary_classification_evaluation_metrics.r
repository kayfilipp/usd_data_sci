#evaluation metrics for binary target variables 

sensitivity <- function(TP,FN){
	return (TP/(TP+FN))
}

specificity <- function(FP,TN){
	return (TN/(FP+TN))
}

precision <- function(TP,FP){
	return (TP/(TP+FP))
}

recall <- function(TN,FP){
	return (TN/(TN+FP))
}

F_beta_score <- function(BETA,precision,recall){
	
	if (abs(BETA) > 1 | BETA == 0){
		return()
	}
	
	return ((1+(BETA**2)) * ((precision * recall)/((beta**2)*precision+recall))
	
}

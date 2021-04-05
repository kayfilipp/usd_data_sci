Module 2 Reading
======================================================================================
	
Tan, P. N., Steinbach, M., Karpatne, A., & Kumar, V. (2019). Introduction to Data Mining (2nd ed.). Pearson
Chapter 3: 3.1, 3.2, & 3.3
	
Larose, C., & Larose, D. (2019). Data Science Using Python and R. John Wiley & Sons, Inc.
Chapter 4
Chapter 6: 6.1, 6.2, & 6.3
Chapter 11
Appendix



1. Tan, P. N., Steinbach, M., & Kumar, V. (2005). Introduction to Data Mining (1st ed.). Pearson
Chapter 3.1-3.3

3.1 - 3.2{

	classification:
	a classification model is an abstract relatinship between object traits and a class it belongs to 
	examples include spam filtering, tumor identification, etc.
	
	applications:
	1. descriptive - identify the characteristics that distinguish an object from different classes.
	2. predictive - used to label previously unlabeled instances 

	discarding dimensions:
	some dimensions dont help in classification while others only help in concert with other dimensions.
	meanwhile, some dimensions are so specific that they fail to classify a general sample
	(ie using skin cover to classify mammals excludes a lot of mammals)
	
	def - induction: the process of using training data to build a model with a learning algorithm 
	def - deduction: the process of applying a model on unseen test instances to predict their classification 
	
	as a general rule, the training set and the test set ought to be completely separate from each other 
	and the induction and deduction processes should occur in separate steps. 
	
	models that can deliver insights on data points they have never encountered before are said to have good 
	generalization performance, which can be analyzed through a DEF - Confusion matrix. 
	
	def - confuson matrix: a chart that shows which instances were identified as positive/negative vs which instances were truly positive/negative 
					Predicted class 
					(0)  (1)
	actual class (0) a    b 
				 (1) c    d 
				 
	a+b+c+d = 1 
	
	def accuracy = correct number of predictions / total number of predictions = (0,0) + (1,1) / (0,0) + (1,1) + (0,1) + (1,0) 
	def error rate = 1 - accuracy 
	
}

3.3{

	basics of decision tree classifiers{
		def: Decision Tree Classifier 
		a classification methodology which asks questions about the nature of an objectss attributes, proceding with follow up questions 
		until we conclusively determine an objects label. 
		
		Types of nodes on a tree 
		1. root node: 
			a node with no incoming links and more than zero outgoing links. this is usually the "beginning" of a tree.
			contains attribute test conditions (ie income < 1000?)
		2. internal nodes:
			has one incoming link and at least two outgoing links. This is an intermediary node which leads to a classification further down the line. 
			contains attribute test conditions (ie age < 30?)
		3. leaf or terminal nodes:	
			one incoming link and no outgoing links. a terminal node ends in a classification. 
		
		Example:								  / c. Yes --> Mammal   		
							/ warm -- b. gives birth 
			a. Body Temperature					  \ d. No --> Non-Mammal 
							\ cold --> e. non-mammal 
		
		a - root node 
		b - internal node 
		c,d,e - terminal or leaf node 
	}
	
	<An algorithm to build a decision tree:>{
		
		1. Hunts Algorithm {
			creates a decision tree in a recursive fashion. 
			if a node is associated with more than one class, it is expanded using a splitting criterion. 
			this happens for every node that has more than one class, recursively.
			once a node does not have any other classes associated with it, splitting ends. 
			
			Design considerations:
			
			1. splitting criterion 
				at each node, what attriute do we evaluate to divide a node into sublcasses? 
			2. termination criterion 
				when do we stop splitting? there is an advantage to ending the splitting process before going through every possible 
				attribute combination.
		}
		
		2. Methods for expressing attribute test conditions {
			1. binary - (y/n, warm blooded/cold blooded, 1/0, etc) 
			2. nominal split - nominal attributes can take on many values (ie marital status) 
				options: multiway split, binary split 
				
				multiway split -> nodes = {married, single, divorced}
				binary   split -> nodes = {married, single/divorced} 
				
			3. ordinal attributes - some attributes have ordinal properties (ie shirt size -> small, medium, large, XL).
			binary splits are permissible as long as they do not violate the ordinal nature of the attribute. 
			
			RIGHT: nodes -> {small, medium, large/XL}
			WRONG: nodes -> {small/large, medium/XL}
			
			4. Continuous attributes options: multiway split (a<C0, C0 < a < C1, a > C1} , binary split: (a <= C, a > C)	 
		}
		
		3. Measures for Selecting an Attribute Test Condition { 
			tldr we want pure nodes.
			impurity measures - gini coefficient, classification rate, entropy 
			if a node only has one class, then all three measures are equal zero.
			if a node has an equal split between classes, all three measures are at their highest.
			
			weighted entropy of the child nodes of a node can also be a way to determine the best classifier.
			if home owner creates two child nodes with a weighted entropy of .69 while splitting 
			on marital status creates three nodes with a weighted entropy of .68, we pick splitting on marital status. 
			
			ULTIMATELY, we need to consider the degree of impurity in the parent node with the weighted impurity of the child nodes. 
			def: gain = delta(I(parent),I(children))
			
			the higher the gain, the less impurity there is in the child nodes compared to the parent node. 
			however, entropy and gini tend to favor attributes with more variables.
			if we parititon by customer_id, we end up with the highest gain, although this doesnt make our model good.
			
			we should take the number of child nodes into account.
			
			def: gain ratio 
			
		}
		
		4. Warnings{
			Decision trees perform badly when attributes are related to each other or interact with each other.
			Trees can handle missing values, and are non-parametric and require no assumptions about data distribution.
			trees can handle redundant attributes, but may not dispose of irrelevant attributes if there's too many of them.'
			
			
		}
	}
}

2. arose, C., & Larose, D. (2019). Data Science Using Python and R. John Wiley & Sons, Inc.
Chapter 4
Chapter 6: 6.1, 6.2, & 6.3
Chapter 11
Appendix

Chapter 4 (Exploratory Data Analysis){
	1. bar graphs with response overlay{
		tldr a bar graph grouped by a catergorical variable split into a distribution for the target variable.
		example: categorical variable - marital status (divorced, separated, married) vs target variable (yes,no) 
		
		**because values for a categorical variable may contain different amounts of objects, it is best practice to NORMALIZE the bar graph.**
		
		Normalizing a bar graph with response overlay in Python{
			import pandas as pd 
			bank_train = pd.read_csv("...dat")
			
			step 1. create a contingency table 
			
			#creates a regular barplot 
			crosstab_01 = pd.crosstab(bank_train['categorical_variable'],banktrain['response_variable'])
			crosstab_01.plot(kind='bar',stacked=True)
			
			#creates a normalized barplot 
			crosstab_norm = crosstab_01.div(crosstab_01.sum(1),axis=0) #sum(1) = sum of the rows of the table, axis = 0 -> divide each row by this value. 
			crosstab_norm.plot(kind='bar',stacked=True)
		}
	
		Normalizing a bar graph with response overlay in R{
			install.packages("ggplot2")
			library(ggplot2)
			
			bank_train = read.csv("dat")
			
			ggplot(bank_train, aes(categorical_variable)) + geom_
			bar(aes(fill = response_variable),position = "fill") + coord_flip()
		}
	
	}
	
	2. Contingency Tables{
		def: a cross tabulation of two variables that contains every possible value combination between the target and predictor variables 
		let the response variable represent the rows and use percentages instead of absolute values. 
		
		#PYTHON 
		crosstab_02 = pd.crosstab(bank_train[’response’], bank_
		train[’predictor’])
		
		#getting percentages:
		round(crosstab_02.div(crosstab_02.sum(0), axis = 1)*100, 1)		#sum(0) to summarize the columns of the table instead of the rows.
		
		#R Language
		#the addmargins function creates a row and column to table A=t.v1 called "total" which contains the sum of the rows and columns 
		t.v1 <- table(bank_train$response, bank_train$previous_outcome)
		t.v2 <- addmargins(A = t.v1, FUN = list(total = sum),quiet = TRUE)	
		#
		round(prop.table(t.v1, margin = 2)*100, 1) #prop.table = Express Table Entries As Fraction Of Marginal Table
													#margin=2 means columns 
													
	}

	3. Histogram with response overlay In Python{
		import numpy as np
		import matplotlib.pyplot as plt
		
		#separate our response value by all possible variables 
		bt_age_y = bank_train[bank_train.response == "yes"]['age']
		bt_age_n = bank_train[bank_train.response == "no"]['age']
		
		plt.hist([bt_age_y, bt_age_n], bins = 10, stacked = True)
		plt.legend([’Response = Yes’, ’Response = No’])
		plt.title(’Histogram of Age with Response Overlay’)
		plt.xlabel(’Age’); plt.ylabel(’Frequency’); plt.show()
		
		#normalization process - save the height of the histogram to n and the boundaries of each bin in the histogram to bins.
		(n, bins, patches) = plt.hist([bt_age_y, bt_age_n], bins =10, stacked = True)
		#normalize 
		n_table = np.column_stack((n[0], n[1]))
		n_norm = n_table / n_table.sum(axis=1)[:, None]
		ourbins = np.column_stack((bins[0:10], bins[1:11]))
		
		p1 = plt.bar(x = ourbins[:,0], height = n_norm[:,0],
		width = ourbins[:, 1] ‐ ourbins[:, 0])
		p2 = plt.bar(x = ourbins[:,0], height = n_norm[:,1],
		width = ourbins[:, 1] ‐ ourbins[:, 0],
		bottom = n_norm[:,0])
		plt.legend([’Response = Yes’, ’Response = No’])
		plt.title(’Normalized Histogram of Age with Response
		Overlay’)
		plt.xlabel(’Age’); plt.ylabel(’Proportion’); plt.show()
	}
	
	4.Histogram with response overlay in R{
		#GET RID OF POSITION=FILL TO UNNORMALIZE
		ggplot(bank_train, aes(predictor_variable)) +
		geom_histogram(aes(fill = response_variable), color="black",
		position = "fill")
	}

	5. Binning based on predictive value { 
	
	}
}

Chapter 11{
	
}



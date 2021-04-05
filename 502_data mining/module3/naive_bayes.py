#NAIVE BAYES IN PYTHON 

import pandas as pd
import numpy as np
from sklearn.naive_bayes import MultinomialNB
import statsmodels.tools.tools as stattools

#get data 
wine_tr = pd.read_csv("C:/.../wine_flag_training.csv")
wine_test = pd.read_csv("C:/.../wine_flag_test.csv")

# get tabulation for probabilities 
t1 = pd.crosstab(wine_tr['Type'], wine_tr['Alcohol_flag'])
t1['Total'] = t1.sum(axis=1)
t1.loc['Total'] = t1.sum()
t1

#convert to dummy variables 
X_Alcohol_ind = np.array(wine_tr['Alcohol_flag'])
(X_Alcohol_ind , X_Alcohol_ind_dict) = stattools.categorical(X_Alcohol_ind,drop=True, dictnames = True)
X_Alcohol_ind = pd.DataFrame(X_Alcohol_ind)
X_Sugar_ind = np.array(wine_tr['Sugar_flag'])
(X_Sugar_ind , X_Sugar_ind_dict) = stattools.categorical(X_Sugar_ind,drop=True, dictnames = True)
X_Sugar_ind = pd.DataFrame(X_Sugar_ind)
X = pd.concat((X_Alcohol_ind, X_Sugar_ind), axis = 1)


#Finally, we move on to the Naïve Bayes algorithm.
Y = wine_tr['Type']
nb_01 = MultinomialNB().fit(X, Y)

#test data 
X_Alcohol_ind_test = np.array(wine_test['Alcohol_flag'])
(X_Alcohol_ind_test, X_Alcohol_ind_dict_test) =
stattools.categorical(X_Alcohol_ind_test,
drop=True, dictnames = True)
X_Alcohol_ind_test = pd.DataFrame(X_Alcohol_ind_test)
X_Sugar_ind_test = np.array(wine_test['Sugar_flag'])
(X_Sugar_ind_test, X_Sugar_ind_dict_test) = stattools.
categorical(X_Sugar_ind_test,
drop=True, dictnames = True)
X_Sugar_ind_test = pd.DataFrame(X_Sugar_ind_test)
X_test = pd.concat((X_Alcohol_ind_test, X_Sugar_ind_
test), axis = 1)

#predict based on test data and generate contingency table for prediction 
Y_predicted = nb_01.predict(X_test)
ypred = pd.crosstab(wine_test[’Type’], Y_predicted,
rownames = [’Actual’],
colnames = [’Predicted’])
ypred[’Total’] = ypred.sum(axis=1); ypred.loc[’Total’] =
ypred.sum(); ypred





#LOGISTIC REGRESSION IN PYTHON 

import pandas as pd
import numpy as np
import statsmodels.api as sm
from scipy import stats

#datasets 
sales_train = pd.read_csv("C:/.../clothing_sales_training.csv")
sales_test = pd.read_csv("C:/.../clothing_sales_test.csv")

#separate variables 
X = pd.DataFrame(sales_train[['Days','Web']])
X = sm.add_constant(X)
Y = pd.DataFrame(sales_train[['CC']])

logreg01 = sm.Logit(Y,X).fit()
logreg01.summary2()

#validation on test set 
X_test = pd.DataFrame(sales_test[[’Days’, ’Web’]])
X_test = sm.add_constant(X_test)
y_test = pd.DataFrame(sales_test[[’CC’]])
logreg01_test = sm.Logit(y_test, X_test).fit()
logreg01_test.summary2()
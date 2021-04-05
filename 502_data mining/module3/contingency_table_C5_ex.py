import warnings
warnings.filterwarnings('ignore')
adult_tr = train 
y = adult_tr[['Income']]
mar_np = np.array(adult_tr['Marital status'])
(mar_cat, mar_cat_dict) = stattools.categorical(mar_np,drop=True, dictnames = True)

mar_cat_pd = pd.DataFrame(mar_cat)
X = pd.concat((adult_tr[['Cap_Gains_Losses']], mar_cat_pd), axis = 1)

X_names = ["Cap_Gains_Losses", "Divorced", "Married","Never-married","Separated", "Widowed"]

y_names = ["<=50K", ">50K"]
c50_01 = DecisionTreeClassifier(criterion="entropy",max_leaf_nodes=5).fit(X,y)
tree.plot_tree(c50_01,feature_names=X_names,class_names=y_names,filled="true");

#and now we use this model to predict for our test data.
#first, we transform our marital status to a categorical variable and bind it to our cap gains.
adult_test = test
y = adult_test[['Income']]
mar_np = np.array(adult_test['Marital status'])
(mar_cat, mar_cat_dict) = stattools.categorical(mar_np,drop=True, dictnames = True)
mar_cat_pd = pd.DataFrame(mar_cat)
X_test = pd.concat((adult_test[['Cap_Gains_Losses']], mar_cat_pd), axis = 1)

#we can now predict for our test data with our C5 model.
#this returns an array of predicted values.
pred = c50_01.predict(X_test)

#convert our array into a dataframe and combine it with the actual incomes.
pred = pd.DataFrame(pred.tolist(),columns=["predicted"])
actual = pd.DataFrame(adult_test.Income)
results = pd.concat([pred,actual],axis=1)

#contingency table 
crosstab_02 = pd.crosstab(results['Income'], results['predicted'])
#getting percentages:
crosstab_02_percent = round(crosstab_02.div(crosstab_02.sum(0), axis = 1)*100, 1)

print(crosstab_02_percent)
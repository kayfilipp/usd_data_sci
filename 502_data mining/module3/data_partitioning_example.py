#HOW TO PARTITION DATA - Python
import pandas as pd
from sklearn.model_selection import train_test_split
import random

bank = pd.read_csv("#.csv")
bank_train, bank_test = train_test_split(bank, test_size =
0.25, random_state = 7)

#verify 
bank.shape
bank_train.shape
bank_test.shape
age = [25,18,9,13,34,15,22,17,12,37,15]
not_in_hs = 0

for age_val in age:
    in_hs = age_val <= 18 and age_val >= 14
    if not in_hs: not_in_hs+=1
    
ratio = (not_in_hs/len(age))

print('% not in HS: ' + str(ratio) )
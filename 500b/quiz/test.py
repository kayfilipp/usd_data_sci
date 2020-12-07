num = 10
for i in range(11):
    for j in range(2, 10, 1):
        if num % 2 == 0:
         continue
         num += 1
        else:
         num-=1
    num+=1
print(num)
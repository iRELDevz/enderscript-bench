a=0
b=0
for i in range(1,200000000+1):
    if i%15==0: a+=1
    elif i%3==0: b=(b+i)%1000003
    elif i%5==0: b=(b+7)%1000003
print(a,b)

f=[0]*1000001
c=0
for r in range(20):
    for i in range(1,1000001): f[i]=0
    for i in range(2,1001):
        if f[i]==0:
            for p in range(i*i,1000001,i): f[p]=1
    for i in range(2,1000001):
        if f[i]==0: c+=1
print(c)

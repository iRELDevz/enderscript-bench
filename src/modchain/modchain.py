s=0
t=1
for i in range(1,100000000+1):
    s=(s*7+i)%1000003
    t=(t+s//7+3)%65521
print(s,t)

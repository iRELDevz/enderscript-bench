x=1
n=0
for k in range(200000000):
    x=(x*1103515245+12345)&0xFFFFFFFF
    if x>=0x80000000: x-=0x100000000
    if x<0 or x%7==0: n+=3
print(n,x)

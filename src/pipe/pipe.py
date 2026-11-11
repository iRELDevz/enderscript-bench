import sys
d=sys.stdin.buffer.read().split()
n=int(d[0]);s=0;o=[]
for k in range(1,n+1):
    x=int(d[k]);s=(s+x)%1000003;o.append(str(x*2+1))
o.append(str(s))
sys.stdout.write("\n".join(o)+"\n")

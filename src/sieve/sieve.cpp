#include <cstdio>
static int f[1000001];
int main(void){int c=0;for(int r=0;r<20;r++){for(int i=1;i<=1000000;i++)f[i]=0;for(int i=2;i<=1000;i++)if(f[i]==0)for(int p=i*i;p<=1000000;p+=i)f[p]=1;for(int i=2;i<=1000000;i++)if(f[i]==0)c++;}printf("%d\n",c);return 0;}

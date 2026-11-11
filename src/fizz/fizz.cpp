#include <cstdio>
int main(void){int a=0,b=0;for(int i=1;i<=200000000;i++){if(i%15==0)a++;else if(i%3==0)b=(b+i)%1000003;else if(i%5==0)b=(b+7)%1000003;}printf("%d %d\n",a,b);return 0;}

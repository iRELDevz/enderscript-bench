#include <stdio.h>
int main(void){int s=0,t=1;for(int i=1;i<=100000000;i++){s=(s*7+i)%1000003;t=(t+s/7+3)%65521;}printf("%d %d\n",s,t);return 0;}

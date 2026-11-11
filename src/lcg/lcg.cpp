#include <cstdio>
int main(void){int x=1,n=0;for(int k=1;k<=200000000;k++){x=(int)((unsigned)x*1103515245u+12345u);if(x<0||x%7==0)n+=3;}printf("%d %d\n",n,x);return 0;}

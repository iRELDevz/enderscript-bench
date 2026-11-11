#include <stdio.h>
static char ib[1<<16],ob[1<<16];
int main(void){setvbuf(stdin,ib,_IOFBF,sizeof ib);setvbuf(stdout,ob,_IOFBF,sizeof ob);int n,x,s=0;if(scanf("%d",&n)!=1)return 1;for(int k=0;k<n;k++){if(scanf("%d",&x)!=1)return 1;s=(s+x)%1000003;printf("%d\n",x*2+1);}printf("%d\n",s);return 0;}

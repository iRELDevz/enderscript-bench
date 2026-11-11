#include <iostream>
int main(){std::ios::sync_with_stdio(false);std::cin.tie(nullptr);int n,x,s=0;std::cin>>n;for(int k=0;k<n;k++){std::cin>>x;s=(s+x)%1000003;std::cout<<x*2+1<<'\n';}std::cout<<s<<'\n';}

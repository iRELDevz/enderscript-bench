fn main(){let(mut s,mut t)=(0i32,1i32);for i in 1..=100000000i32 {s=(s*7+i)%1000003;t=(t+s/7+3)%65521;}println!("{} {}",s,t);}

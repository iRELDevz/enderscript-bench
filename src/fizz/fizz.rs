fn main(){let(mut a,mut b)=(0i32,0i32);for i in 1..=200000000i32 {if i%15==0{a+=1;}else if i%3==0{b=(b+i)%1000003;}else if i%5==0{b=(b+7)%1000003;}}println!("{} {}",a,b);}

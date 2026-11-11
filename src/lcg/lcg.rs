fn main(){let mut x:i32=1;let mut n:i32=0;for _ in 1..=200000000 {x=x.wrapping_mul(1103515245).wrapping_add(12345);if x<0||x%7==0{n+=3;}}println!("{} {}",n,x);}

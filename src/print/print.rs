use std::io::Write;
fn main(){let o=std::io::stdout();let mut w=std::io::BufWriter::new(o.lock());for i in 1..=1000000 {writeln!(w,"{}",i).unwrap();}}

const std=@import("std");
pub fn main(init: std.process.Init) !void {
 var x:i32=1; var n:i32=0; var k:i32=1;
 while(k<=200000000):(k+=1){ x=x*%1103515245+%12345; if(x<0 or @rem(x,7)==0) n+=3; }
 var b:[64]u8=undefined; var w: std.Io.File.Writer = .init(.stdout(), init.io, &b);
 try w.interface.print("{d} {d}\n",.{n,x}); try w.interface.flush();
}

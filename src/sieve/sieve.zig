const std=@import("std");
var f:[1000001]i32=undefined;
pub fn main(init: std.process.Init) !void {
 var c:i32=0; var r:usize=0;
 while(r<20):(r+=1){ var i:usize=1; while(i<=1000000):(i+=1) f[i]=0; i=2; while(i<=1000):(i+=1){ if(f[i]==0){ var p=i*i; while(p<=1000000):(p+=i) f[p]=1; } } i=2; while(i<=1000000):(i+=1){ if(f[i]==0) c+=1; } }
 var buf:[64]u8=undefined; var w: std.Io.File.Writer = .init(.stdout(), init.io, &buf);
 try w.interface.print("{d}\n",.{c}); try w.interface.flush();
}

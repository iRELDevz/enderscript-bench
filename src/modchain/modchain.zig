const std=@import("std");
pub fn main(init: std.process.Init) !void {
 var s:i32=0; var t:i32=1; var i:i32=1;
 while(i<=100000000):(i+=1){ s=@rem(s*7+i,1000003); t=@rem(t+@divTrunc(s,7)+3,65521); }
 var buf:[64]u8=undefined; var w: std.Io.File.Writer = .init(.stdout(), init.io, &buf);
 try w.interface.print("{d} {d}\n",.{s,t}); try w.interface.flush();
}

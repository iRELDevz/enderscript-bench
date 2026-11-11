const std=@import("std");
pub fn main(init: std.process.Init) !void {
 var a:i32=0; var b:i32=0; var i:i32=1;
 while(i<=200000000):(i+=1){ if(@rem(i,15)==0){a+=1;} else if(@rem(i,3)==0){b=@rem(b+i,1000003);} else if(@rem(i,5)==0){b=@rem(b+7,1000003);} }
 var buf:[64]u8=undefined; var w: std.Io.File.Writer = .init(.stdout(), init.io, &buf);
 try w.interface.print("{d} {d}\n",.{a,b}); try w.interface.flush();
}

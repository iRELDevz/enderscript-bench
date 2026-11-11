const std=@import("std");
pub fn main(init: std.process.Init) !void {
 var buf:[65536]u8=undefined; var w: std.Io.File.Writer = .init(.stdout(), init.io, &buf);
 var i:i32=1; while(i<=1000000):(i+=1) try w.interface.print("{d}\n",.{i});
 try w.interface.flush();
}

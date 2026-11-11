const std=@import("std");
pub fn main(init: std.process.Init) !void {
 var rb:[65536]u8=undefined; var r: std.Io.File.Reader = .init(.stdin(), init.io, &rb);
 var buf:[65536]u8=undefined; var w: std.Io.File.Writer = .init(.stdout(), init.io, &buf);
 const n = try std.fmt.parseInt(i32, std.mem.trim(u8, try r.interface.takeDelimiterInclusive('\n'), " \r\n"), 10);
 var s:i32=0; var k:i32=0;
 while(k<n):(k+=1){ const x = try std.fmt.parseInt(i32, std.mem.trim(u8, try r.interface.takeDelimiterInclusive('\n'), " \r\n"), 10); s=@rem(s+x,1000003); try w.interface.print("{d}\n",.{x*2+1}); }
 try w.interface.print("{d}\n",.{s}); try w.interface.flush();
}

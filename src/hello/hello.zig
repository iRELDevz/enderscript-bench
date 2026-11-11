const std=@import("std");
pub fn main(init: std.process.Init) !void {
 var b:[256]u8=undefined; var w: std.Io.File.Writer = .init(.stdout(), init.io, &b);
 try w.interface.writeAll("Hello, World!\n"); try w.interface.flush();
}

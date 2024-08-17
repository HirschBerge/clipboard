const std = @import("std");
const builtin = @import("builtin");
const win = @import("clipboard_windows.zig");
const macos = @import("clipboard_macos.zig");
const testing = std.testing;

pub fn read() ![]const u8 {
    switch (builtin.os.tag) {
        .windows => return try win.read(),
        .macos => return try macos.read(),
        //.unix => unix.read(),
        else => @compileError("platform not currently supported"),
    }
}

pub fn write(text: []const u8) !void {
    switch (builtin.os.tag) {
        .windows => try win.write(text),
        .macos => try macos.write(text),
        //.unix => unix.read(),
        else => @compileError("platform not currently supported"),
    }
}

test "copy/paste" {
    const text = "zig zag ⚡";
    try write(text);
    const r = try read();
    try std.testing.expect(std.mem.eql(u8, r, text));
}

const std = @import("std");

pub fn get_writer() *std.Io.Writer {
    var buffer: [1024]u8 = undefined;

    var writer = std.fs.File.stdout().writer(&buffer);

    return &writer.interface;
}

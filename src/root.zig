const std = @import("std");

pub fn get_writer() *std.Io.Writer {
    var buffer: [1024]u8 = undefined;

    var writer = std.fs.File.stdout().writer(&buffer);

    return &writer.interface;
}

test "write_test" {
    var w = get_writer();
    const got = try w.write("1234567890");
    const expected: usize = 10;

    try std.testing.expectEqual(expected, got);
}

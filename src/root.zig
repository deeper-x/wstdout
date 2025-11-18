const std = @import("std");

const Writer = struct {
    interface: *std.Io.Writer,

    pub fn init(comptime S: usize) @This() {
        var buffer: [S]u8 = undefined;

        var writer = std.fs.File.stdout().writer(&buffer);

        return .{
            .interface = &writer.interface,
        };
    }

    pub fn create(comptime S: usize) *std.Io.Writer {
        var buffer: [S]u8 = undefined;
        var writer = std.fs.File.stdout().writer(&buffer);

        return &writer.interface;
    }
};

test "write_test_init" {
    var w = Writer.init(1024);

    const got = try w.interface.write("1234567890");
    const expected: usize = 10;

    try std.testing.expectEqual(expected, got);
}

test "write_test_create" {
    var w = Writer.create(1024);
    const got = try w.write("1234567");
    const expected = 7;

    try std.testing.expectEqual(expected, got);
}

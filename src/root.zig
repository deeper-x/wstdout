const std = @import("std");

pub const Writer = struct {
    allocator: std.mem.Allocator,
    buffer: []u8,
    writer: std.fs.File.Writer,

    pub fn init(allocator: std.mem.Allocator, comptime S: usize) !@This() {
        const buffer = try allocator.alloc(u8, S);

        return .{
            .writer = std.fs.File.stdout().writer(buffer),
            .allocator = allocator,
            .buffer = buffer,
        };
    }

    pub fn interface(self: *@This()) *std.io.Writer {
        return &self.writer.interface;
    }

    pub fn flush(self: *@This()) !void {
        try self.writer.interface.flush();
    }

    pub fn deinit(self: *@This()) void {
        self.allocator.free(self.buffer);
    }
};

test "write_test_init" {
    const allocator = std.testing.allocator;
    const size: usize = 10;

    var w = try Writer.init(allocator, size);
    defer w.deinit();

    const stdout = w.interface();

    const got = try stdout.write("hello test");
    // try stdout.flush(); <-- no flush required in testing

    try std.testing.expectEqual(size, got);
}

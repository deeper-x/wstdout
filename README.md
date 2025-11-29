wstdout - A library for writing wide character strings to standard output in Zig.

Usage:

Case 1 - Calling its interface:
```zig
const wstdout = @import("wstdout");

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    var w = try wstdout.Writer.init(allocator, 1024);
    defer w.deinit();

    const stdout = w.interface();

    try stdout.print("test library\n", .{});
    try stdout.flush();

    // Output:
    // test library
}
```

Install:
```sh
zig fetch --save https://github.com/deeper-x/wstdout/archive/refs/heads/main.zip
```

Setup build.zig:
```zig
const wstdout = b.dependency("wstdout", .{
    .target = target,
    .optimize = optimize,
});

exe.root_module.addImport("wstdout", wstdout.module("wstdout"));
```

Test:
```sh
zig build test --summary all

Build Summary: 5/5 steps succeeded; 1/1 tests passed
test success
├─ run test 1 passed 270us MaxRSS:2M
│  └─ compile test Debug native success 367ms MaxRSS:120M
└─ run test success 197us MaxRSS:2M
   └─ compile test Debug native success 387ms MaxRSS:120M

```

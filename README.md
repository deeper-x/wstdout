wstdout - A library for writing wide character strings to standard output in Zig.

Usage:

Case 1 - Calling its interface:
```zig
const wstdout = @import("wstdout");

pub fn main() !void {
    var w = wstdout.Writer.init(1024);

    try w.interface.print("test library\n", .{});
    try w.interface.flush();

    // Output:
    // test library
}
```

Case 2 - Calling it directly:
```zig
const wstdout = @import("wstdout");

pub fn main() !void {
    var w = wstdout.Writer.create(1024);
    
    try w.print("test library again\n", .{});
    try w.flush();

    // Output:
    // test library again
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
$ zig build test --summary all

Build Summary: 5/5 steps succeeded; 1/1 tests passed
test success
├─ run test 1 passed 257us MaxRSS:2M
│  └─ compile test Debug native cached 9ms MaxRSS:38M
└─ run test success 136us MaxRSS:2M
   └─ compile test Debug native success 303ms MaxRSS:120M

```

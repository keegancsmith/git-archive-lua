const std = @import("std");
const ziglua = @import("ziglua");

const Lua = ziglua.Lua;

pub fn main() !void {
    // Create an allocator
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    // Initialize the Lua vm
    var lua = try Lua.init(allocator);
    defer lua.deinit();

    // Compile a line of Lua code
    try lua.loadString("return true");
    lua.setGlobal("f");
    std.debug.print("{}\n", .{lua.getTop()});

    _ = try lua.getGlobal("f");
    try lua.protectedCall(0, 1, 0);
    std.debug.print("{}\n", .{lua.toBoolean(1)});
    lua.pop(1);
    std.debug.print("{}\n", .{lua.getTop()});

    _ = try lua.getGlobal("f");
    try lua.protectedCall(0, 1, 0);
    std.debug.print("{}\n", .{lua.toBoolean(1)});
    lua.pop(1);
    std.debug.print("{}\n", .{lua.getTop()});
}

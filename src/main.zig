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
    try lua.loadString("return 1");
    lua.setGlobal("f");

    _ = try lua.getGlobal("f");
    try lua.protectedCall(0, 1, 0);
    std.debug.print("{}\n", .{try lua.toInteger(1)});

    _ = try lua.getGlobal("f");
    try lua.protectedCall(0, 1, 0);
    std.debug.print("{}\n", .{try lua.toInteger(1)});
}

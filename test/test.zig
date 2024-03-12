const std = @import("std");
const testing = std.testing;

export fn add(a: c_int, b: c_int) c_int {
    return a + b;
}

test "basic add functionality" {
    try testing.expect(add(3, 7) == 10);
}

const std = @import("std");

const c = @cImport({
    @cInclude("C/string.h");
    @cInclude("user/user.h");
});

fn help() void {
    _ = c.printf("Usage: clear [OPTION]\n");
    _ = c.printf("Clear the terminal screen.\n\n");
    _ = c.printf("  --help     display this help and exit\n");
    _ = c.printf("  --version  output version information and exit\n");
}

fn prog() void {
    _ = c.printf("clear 1.0\n");
}

export fn main(argc: c_int, argv: [*c][*c]u8) c_int {
    if (argc > 1) {
        if (c.strcmp(argv[1], "--help") == 0) {
            help();
            return 0;
        } else if (c.strcmp(argv[1], "--version") == 0) {
            prog();
            return 0;
        } else {
            _ = c.printf("clear: invalid option %s\n", argv[1]);
            _ = c.printf("Try 'clear --help' for more information.\n");
            return 1;
        }
    }

    const clear_sequence = "\x1B[2J\x1B[H";
    _ = c.write(1, clear_sequence, clear_sequence.len);
    return 0;
}

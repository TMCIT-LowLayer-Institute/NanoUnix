const kern = @cImport({
    @cInclude("kern/types.h");
    @cInclude("kern/stat.h");
});

const user = @cImport({
    @cInclude("user/user.h");
});

pub export fn shutdown() void {
    user.poweroff();
    user.exit(1);
}

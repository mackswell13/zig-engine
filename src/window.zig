const rl = @import("raylib");


pub const Window = struct {
    width: u16,
    height: u16,
    title: []const u8,


    pub fn init(self: *Window) void {
        rl.initWindow(self.width, self.height, self.title.ptr);

    }

    pub fn running() bool {
        return !rl.windowShouldClose();
    }

    pub fn beginDrawing() void {
        rl.beginDrawing();
    }


    pub fn endDrawing() void {
        rl.EndDrawing();
    }

    pub fn close() void {
        rl.CloseWindow();
    }


};
